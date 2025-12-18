defmodule ElixirKatasWeb.Kata55SlideoverLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_55_slideover_notes.md")

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:show_slideover, false)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 55: Slideover" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
           Interactive slideover demonstration.
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">

          <button phx-click="toggle_slideover" class="px-4 py-2 bg-indigo-600 text-white rounded">
            Open Slide-over
          </button>
          <%= if @show_slideover do %>
            <div class="fixed inset-0 bg-black bg-opacity-50 z-50" phx-click="toggle_slideover">
              <div class="fixed right-0 top-0 h-full w-96 bg-white shadow-xl p-6" phx-click="prevent_close">
                <h3 class="text-lg font-bold mb-4">Slide-over Panel</h3>
                <p class="text-gray-600">This is a slide-over drawer from the right side.</p>
                <button phx-click="toggle_slideover" class="mt-4 px-4 py-2 bg-gray-200 rounded">Close</button>
              </div>
            </div>
          <% end %>
    
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("toggle_slideover", _, socket) do
    {:noreply, assign(socket, show_slideover: !socket.assigns.show_slideover)}
  end

  def handle_event("show_message", _, socket) do
    {:noreply, assign(socket, show_slideover: true)}
  end

  def handle_event("hide_flash", _, socket) do
    {:noreply, assign(socket, show_slideover: false)}
  end

  def handle_event("prevent_close", _, socket) do
    {:noreply, socket}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
