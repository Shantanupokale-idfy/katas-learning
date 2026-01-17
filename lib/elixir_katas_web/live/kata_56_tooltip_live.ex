defmodule ElixirKatasWeb.Kata56TooltipLive do
  use ElixirKatasWeb, :live_component

  def update(assigns, socket) do
    socket = assign(socket, assigns)
    socket =
      socket
      |> assign(active_tab: "notes")
      
      
      |> assign(:show_tooltip, false)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
           Interactive tooltip demonstration.
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">

          <div class="space-y-4">
            <div class="relative inline-block">
              <button class="px-4 py-2 bg-indigo-600 text-white rounded" phx-click="toggle_tooltip" phx-target={@myself}>
                Hover me
              </button>
              <%= if @show_tooltip do %>
                <div class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 px-3 py-2 bg-gray-900 text-white text-sm rounded whitespace-nowrap">
                  This is a tooltip!
                </div>
              <% end %>
            </div>
          </div>
    
        </div>
      </div>
    
    """
  end

  def handle_event("toggle_tooltip", _, socket) do
    {:noreply, assign(socket, show_tooltip: !socket.assigns.show_tooltip)}
  end

  def handle_event("show_message", _, socket) do
    {:noreply, assign(socket, show_tooltip: true)}
  end

  def handle_event("hide_flash", _, socket) do
    {:noreply, assign(socket, show_tooltip: false)}
  end

  def handle_event("prevent_close", _, socket) do
    {:noreply, socket}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
