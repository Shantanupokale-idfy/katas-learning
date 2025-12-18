defmodule ElixirKatasWeb.Kata18EditorLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_18_editor_notes.md")

    initial_items = [
      %{id: "1", text: "Buy Milk"},
      %{id: "2", text: "Walk the Dog"},
      %{id: "3", text: "Write Elixir Code"}
    ]

    {:ok, 
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(items: initial_items)
     |> assign(editing_id: nil)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 18: The Editor" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center p-8 gap-8">
        <div class="w-full max-w-md">
           <h3 class="text-lg font-semibold mb-4 text-center">Click to Edit</h3>
           
           <ul class="space-y-2">
             <%= for item <- @items do %>
               <li class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 min-h-[4rem] flex items-center">
                 <%= if @editing_id == item.id do %>
                   <form phx-submit="save" phx-change="validate" class="w-full flex gap-2">
                     <input type="hidden" name="id" value={item.id} />
                     <input 
                       type="text" 
                       name="text" 
                       value={item.text} 
                       class="input input-sm input-bordered flex-1" 
                       autofocus 
                       phx-blur="cancel"
                     />
                     <button type="submit" class="btn btn-sm btn-primary">Save</button>
                   </form>
                 <% else %>
                   <div 
                     phx-click="edit" 
                     phx-value-id={item.id} 
                     class="w-full cursor-text hover:bg-gray-50 dark:hover:bg-gray-700 p-2 rounded transition-colors"
                   >
                     {item.text}
                   </div>
                 <% end %>
               </li>
             <% end %>
           </ul>
             
           <div class="mt-4 text-center text-xs text-gray-400">
             (Click any text to edit properly. Blur cancels editing.)
           </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply, assign(socket, editing_id: id)}
  end

  def handle_event("cancel", _, socket) do
    {:noreply, assign(socket, editing_id: nil)}
  end

  def handle_event("validate", _, socket), do: {:noreply, socket}

  def handle_event("save", %{"id" => id, "text" => text}, socket) do
    new_items = Enum.map(socket.assigns.items, fn item -> 
      if item.id == id, do: %{item | text: text}, else: item
    end)
    {:noreply, assign(socket, items: new_items, editing_id: nil)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end
end
