defmodule ElixirKatasWeb.Kata16ListLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_16_list_notes.md")

    {:ok, 
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(items: ["Learn Elixir", "Master LiveView"])
     |> assign(new_item: "")}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 16: The List" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center p-8 gap-8">
        <form phx-submit="add" class="flex gap-2 w-full max-w-md">
          <input 
            type="text" 
            name="text" 
            value={@new_item} 
            placeholder="Add new item..." 
            class="input input-bordered flex-1"
            required
            autocomplete="off"
          />
          <button class="btn btn-primary">Add</button>
        </form>

        <div class="w-full max-w-md text-left">
           <h3 class="text-lg font-semibold mb-2">My List ({length(@items)})</h3>
           <ul class="menu bg-base-200 w-full rounded-box">
             <%= for item <- @items do %>
               <li><a>{item}</a></li>
             <% end %>
           </ul>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("add", %{"text" => text}, socket) do
    {:noreply, update(socket, :items, fn items -> items ++ [text] end) |> assign(new_item: "")}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end
end
