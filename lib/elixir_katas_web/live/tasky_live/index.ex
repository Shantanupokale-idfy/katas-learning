defmodule ElixirKatasWeb.TaskyLive.Index do
  use ElixirKatasWeb, :live_view
  alias ElixirKatas.Tasky
  alias ElixirKatas.Tasky.Todo

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Tasky.subscribe()
    end

    user_id = socket.assigns.current_scope.user.id
    categories = Tasky.list_categories(user_id)

    {:ok, 
     socket
     |> assign(:page_title, "Tasky")
     |> assign(:form, to_form(Tasky.change_todo(%Todo{})))
     |> assign(:show_confirm_modal, false)
     |> assign(:confirm_delete_id, nil)
     |> assign(:categories, categories)
     |> stream(:todos, [])}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    search = params["search"] || ""
    category = params["category"] || ""
    priority = params["priority"] || ""
    due_date_filter = params["due_date_filter"] || ""
    per_page = 5
    
    user_id = socket.assigns.current_scope.user.id
    pagination = Tasky.list_todos(user_id, 
      page: page, 
      per_page: per_page, 
      search: search,
      category: category,
      priority: priority,
      due_date_filter: due_date_filter
    )
    
    {:noreply,
     socket
     |> assign(:page, page)
     |> assign(:per_page, per_page)
     |> assign(:search, search)
     |> assign(:category, category)
     |> assign(:priority, priority)
     |> assign(:due_date_filter, due_date_filter)
     |> assign(:total_pages, pagination.total_pages)
     |> stream(:todos, pagination.entries, reset: true)}
  end

  def handle_event("search", %{"query" => search}, socket) do
    {:noreply, push_patch(socket, to: build_url(socket, %{search: search, page: 1}))}
  end

  def handle_event("filter_category", %{"category" => category}, socket) do
    {:noreply, push_patch(socket, to: build_url(socket, %{category: category, page: 1}))}
  end

  def handle_event("filter_priority", %{"priority" => priority}, socket) do
    {:noreply, push_patch(socket, to: build_url(socket, %{priority: priority, page: 1}))}
  end

  def handle_event("filter_due_date", %{"due_date_filter" => due_date_filter}, socket) do
    {:noreply, push_patch(socket, to: build_url(socket, %{due_date_filter: due_date_filter, page: 1}))}
  end

  def handle_event("clear_filters", _params, socket) do
    {:noreply, push_patch(socket, to: build_url(socket, %{category: "", priority: "", due_date_filter: "", page: 1}))}
  end

  def handle_event("validate", %{"todo" => todo_params}, socket) do
    form =
      %Todo{}
      |> Tasky.change_todo(todo_params)
      |> to_form(action: :validate)

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case Tasky.create_todo(socket.assigns.current_scope.user.id, todo_params) do
      {:ok, _todo} ->
        search = socket.assigns.search
        total_pages = ceil(Tasky.count_todos(socket.assigns.current_scope.user.id, search) / socket.assigns.per_page)
        
        {:noreply,
         socket
         |> assign(:total_pages, total_pages)
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

  def handle_event("delete_todo", %{"id" => id}, socket) do
    todo = Tasky.get_todo!(id)
    {:ok, _} = Tasky.delete_todo(todo)
    
    search = socket.assigns.search
    total_pages = ceil(Tasky.count_todos(socket.assigns.current_scope.user.id, search) / socket.assigns.per_page)
    
    {:noreply,
     socket
     |> assign(:total_pages, total_pages)
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

  defp build_url(socket, updates) do
    params = %{
      "page" => to_string(updates[:page] || socket.assigns.page),
      "search" => updates[:search] || socket.assigns.search,
      "category" => updates[:category] || socket.assigns.category,
      "priority" => updates[:priority] || socket.assigns.priority,
      "due_date_filter" => updates[:due_date_filter] || socket.assigns.due_date_filter
    }
    |> Enum.reject(fn {_k, v} -> v == "" end)
    |> Enum.map(fn {k, v} -> "#{k}=#{URI.encode_www_form(v)}" end)
    |> Enum.join("&")

    "/usecases/tasky?" <> params
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
          <div class="mb-6">
             <div class="relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <.icon name="hero-magnifying-glass" class="h-5 w-5 text-gray-400" />
                </div>
                <form phx-change="search" phx-submit="search">
                  <input 
                    type="text" 
                    name="query" 
                    value={@search}
                    placeholder="Search tasks..." 
                    class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md" 
                  />
                </form>
             </div>
          </div>

          <!-- Filter Controls -->
          <div class="mb-6 space-y-3">
            <div class="flex flex-wrap gap-2">
              <select phx-change="filter_category" name="category" class="text-sm border-gray-300 rounded-md">
                <option value="">All Categories</option>
                <option :for={cat <- @categories} value={cat} selected={@category == cat}>{cat}</option>
              </select>

              <select phx-change="filter_priority" name="priority" class="text-sm border-gray-300 rounded-md">
                <option value="">All Priorities</option>
                <option value="high" selected={@priority == "high"}>High</option>
                <option value="medium" selected={@priority == "medium"}>Medium</option>
                <option value="low" selected={@priority == "low"}>Low</option>
              </select>

              <select phx-change="filter_due_date" name="due_date_filter" class="text-sm border-gray-300 rounded-md">
                <option value="">All Dates</option>
                <option value="overdue" selected={@due_date_filter == "overdue"}>Overdue</option>
                <option value="today" selected={@due_date_filter == "today"}>Due Today</option>
                <option value="week" selected={@due_date_filter == "week"}>This Week</option>
                <option value="no_date" selected={@due_date_filter == "no_date"}>No Date</option>
              </select>

              <%= if @category != "" || @priority != "" || @due_date_filter != "" do %>
                <button phx-click="clear_filters" class="text-sm text-indigo-600 hover:text-indigo-800">
                  Clear Filters
                </button>
              <% end %>
            </div>
          </div>

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
            
            <div class="grid grid-cols-3 gap-3">
              <div>
                <.input field={@form[:category]} type="text" placeholder="Category" list="categories-list"
                  class="focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md" />
                <datalist id="categories-list">
                  <option :for={cat <- @categories} value={cat}>{cat}</option>
                </datalist>
              </div>
              
              <div>
                <.input field={@form[:priority]} type="select" options={[{"Low", "low"}, {"Medium", "medium"}, {"High", "high"}]}
                  class="focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md" />
              </div>
              
              <div>
                <.input field={@form[:due_date]} type="date"
                  class="focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md" />
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
          
          <!-- Pagination -->
          <div class="mt-6 flex items-center justify-between border-t border-gray-200 pt-4">
            <div class="flex flex-1 justify-between sm:hidden">
              <.link :if={@page > 1} patch={~p"/usecases/tasky?page=#{@page - 1}&search=#{@search}"} class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">
                Previous
              </.link>
              <.link :if={@page < @total_pages} patch={~p"/usecases/tasky?page=#{@page + 1}&search=#{@search}"} class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">
                Next
              </.link>
            </div>
            <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
              <div>
                <p class="text-sm text-gray-700">
                  Showing page <span class="font-medium"><%= @page %></span> of <span class="font-medium"><%= @total_pages %></span>
                </p>
              </div>
              <div>
                <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
                  <.link :if={@page > 1} patch={~p"/usecases/tasky?page=#{@page - 1}&search=#{@search}"} class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                    <span class="sr-only">Previous</span>
                    <.icon name="hero-chevron-left-mini" class="h-5 w-5" />
                  </.link>
                  <.link :if={@page < @total_pages} patch={~p"/usecases/tasky?page=#{@page + 1}&search=#{@search}"} class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                    <span class="sr-only">Next</span>
                    <.icon name="hero-chevron-right-mini" class="h-5 w-5" />
                  </.link>
                </nav>
              </div>
            </div>
          </div>
          

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
