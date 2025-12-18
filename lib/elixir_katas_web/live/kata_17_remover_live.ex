defmodule ElixirKatasWeb.Kata17RemoverLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_17_remover_notes.md")

    initial_items = [
      %{id: Ecto.UUID.generate(), text: "Learn LiveView"},
      %{id: Ecto.UUID.generate(), text: "Build a Side Project"},
      %{id: Ecto.UUID.generate(), text: "Ship to Production"}
    ]

    {:ok, 
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(items: initial_items)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 17: The Remover" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center p-8 gap-8">
        <div class="w-full max-w-md">
           <h3 class="text-lg font-semibold mb-4 text-center">Todo List ({length(@items)})</h3>
           
           <%= if Enum.empty?(@items) do %>
             <div class="text-center text-gray-500 py-8">
               Nothing left to do! <button phx-click="reset" class="link link-primary">Reset</button>
             </div>
           <% else %>
             <ul class="space-y-2">
               <%= for item <- @items do %>
                 <li class="flex items-center justify-between p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700">
                   <span>{item.text}</span>
                   <button 
                     phx-click="remove" 
                     phx-value-id={item.id} 
                     class="btn btn-sm btn-circle btn-ghost text-error"
                     aria-label="Remove"
                   >
                     <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
                   </button>
                 </li>
               <% end %>
             </ul>
           <% end %>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("remove", %{"id" => id}, socket) do
    new_items = Enum.reject(socket.assigns.items, fn i -> i.id == id end)
    {:noreply, assign(socket, items: new_items)}
  end
  
  def handle_event("reset", _, socket) do
     initial_items = [
      %{id: Ecto.UUID.generate(), text: "Learn LiveView"},
      %{id: Ecto.UUID.generate(), text: "Build a Side Project"},
      %{id: Ecto.UUID.generate(), text: "Ship to Production"}
    ]
    {:noreply, assign(socket, items: initial_items)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end
end
