defmodule ElixirKatasWeb.TaskyLive.Index do
  use ElixirKatasWeb, :live_view
  alias ElixirKatas.Tasky
  alias ElixirKatas.Tasky.Todo

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Tasky.subscribe()
    end

    {:ok, 
     socket
     |> assign(:page_title, "Tasky")
     |> stream(:todos, Tasky.list_todos())
     |> assign(:form, to_form(Tasky.change_todo(%Todo{})))
     |> assign(:show_confirm_modal, false)
     |> assign(:confirm_delete_id, nil)}
  end

  def handle_event("validate", %{"todo" => todo_params}, socket) do
    form =
      %Todo{}
      |> Tasky.change_todo(todo_params)
      |> to_form(action: :validate)

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case Tasky.create_todo(todo_params) do
      {:ok, todo} ->
        {:noreply,
         socket
         |> stream_insert(:todos, todo, at: 0)
         |> assign(:form, to_form(Tasky.change_todo(%Todo{})))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def handle_event("toggle_complete", %{"id" => id}, socket) do
    todo = Tasky.get_todo!(id)
    {:ok, updated_todo} = Tasky.update_todo(todo, %{is_complete: !todo.is_complete})
    {:noreply, stream_insert(socket, :todos, updated_todo)}
  end

  def handle_event("toggle_favorite", %{"id" => id}, socket) do
    todo = Tasky.get_todo!(id)
    {:ok, updated_todo} = Tasky.update_todo(todo, %{is_favorite: !todo.is_favorite})
    {:noreply, stream_insert(socket, :todos, updated_todo)}
  end

  def handle_event("confirm_delete", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> assign(:confirm_delete_id, id)
     |> assign(:show_confirm_modal, true)}
  end

  def handle_event("cancel_delete", _params, socket) do
    {:noreply,
     socket
     |> assign(:confirm_delete_id, nil)
     |> assign(:show_confirm_modal, false)}
  end

  def handle_event("delete_todo", _params, socket) do
    if id = socket.assigns.confirm_delete_id do
      todo = Tasky.get_todo!(id)
      Tasky.delete_todo(todo)
    end
    
    {:noreply,
     socket
     |> assign(:confirm_delete_id, nil)
     |> assign(:show_confirm_modal, false)}
  end

  def handle_info({:todo_created, todo}, socket) do
    {:noreply, stream_insert(socket, :todos, todo, at: 0)}
  end

  def handle_info({:todo_updated, todo}, socket) do
    {:noreply, stream_insert(socket, :todos, todo)}
  end

  def handle_info({:todo_deleted, todo}, socket) do
    {:noreply, stream_delete(socket, :todos, todo)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div class="sm:mx-auto sm:w-full sm:max-w-md">
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Tasky
        </h2>
        <p class="mt-2 text-center text-sm text-gray-600">
          Simplify your day
        </p>
      </div>

      <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <!-- Add Task Form -->
          <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-4 mb-8">
            <div>
              <label for="title" class="sr-only">New Task</label>
              <div class="relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <.icon name="hero-plus" class="h-5 w-5 text-gray-400" />
                </div>
                <.input field={@form[:title]} type="text" placeholder="Add a new task..." 
                  class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md" />
              </div>
            </div>
          </.form>

          <!-- Todo List -->
          <ul id="todos" phx-update="stream" class="divide-y divide-gray-200">
            <li :for={{id, todo} <- @streams.todos} id={id} class="py-4 flex items-center justify-between group">
              <div class="flex items-center">
                <button phx-click="toggle_complete" phx-value-id={todo.id} class="focus:outline-none">
                  <%= if todo.is_complete do %>
                    <.icon name="hero-check-circle-solid" class="h-6 w-6 text-green-500" />
                  <% else %>
                    <.icon name="hero-check-circle" class="h-6 w-6 text-gray-300 group-hover:text-green-500 transition-colors" />
                  <% end %>
                </button>
                <span class={"ml-3 text-sm font-medium #{if todo.is_complete, do: "text-gray-400 line-through", else: "text-gray-900"}"}>
                  <%= todo.title %>
                </span>
              </div>
              <div class="flex items-center gap-2">
                <button phx-click="toggle_favorite" phx-value-id={todo.id} class="focus:outline-none transition-transform active:scale-95 group/fav">
                   <%= if todo.is_favorite do %>
                     <.icon name="hero-star-solid" class="h-5 w-5 text-yellow-500" />
                   <% else %>
                     <.icon name="hero-star" class="h-5 w-5 text-gray-300 group-hover/fav:text-yellow-400" />
                   <% end %>
                </button>
                <button phx-click="confirm_delete" phx-value-id={todo.id} class="text-gray-400 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity">
                  <.icon name="hero-trash" class="h-5 w-5" />
                </button>
              </div>
            </li>
          </ul>
          

        </div>
      </div>

      <%= if @show_confirm_modal do %>
      <.modal 
        id="confirm_modal" 
        show={@show_confirm_modal} 
        on_cancel={Phoenix.LiveView.JS.push("cancel_delete")}
      >
        <div class="p-4 sm:p-6 text-center">
            <div class="mx-auto flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-full bg-red-100 mb-4">
              <.icon name="hero-exclamation-triangle" class="h-6 w-6 text-red-600" />
            </div>
            <h3 class="text-base font-semibold leading-6 text-gray-900 mb-2">Delete Task</h3>
            <p class="text-sm text-gray-500 mb-6">Are you sure you want to delete this task? This action cannot be undone.</p>
            
            <div class="flex justify-end gap-3">
              <button 
                phx-click="cancel_delete"
                class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
              >
                Cancel
              </button>
              <button 
                phx-click="delete_todo"
                class="rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500"
              >
                Delete
              </button>
            </div>
        </div>
      </.modal>
      <% end %>
    </div>
    """
  end
end
