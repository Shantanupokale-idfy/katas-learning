defmodule ElixirKatasWeb.Kata84AccessibleFocusLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_84_focus_notes.md")

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:focused_element, nil)
      |> assign(:announcement, "")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 84: Accessible Focus" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
          Demonstrates focus management and ARIA attributes for accessibility.
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border space-y-4">
          <div role="status" aria-live="polite" class="sr-only">
            <%= @announcement %>
          </div>

          <div class="space-y-2">
            <button 
              id="button-1"
              phx-click="focus_element" 
              phx-value-element="button-1"
              class="w-full px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
              aria-label="First interactive button"
            >
              Button 1
            </button>

            <button 
              id="button-2"
              phx-click="focus_element" 
              phx-value-element="button-2"
              class="w-full px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
              aria-label="Second interactive button"
            >
              Button 2
            </button>

            <input 
              id="input-1"
              type="text" 
              placeholder="Focusable input"
              class="w-full px-4 py-2 border rounded focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
              aria-label="Text input field"
            />
          </div>

          <div class="p-4 bg-gray-50 rounded">
            <div class="text-sm font-medium mb-2">Focus Information:</div>
            <div class="text-sm text-gray-600">
              <%= if @focused_element do %>
                Currently focused: <span class="font-mono"><%= @focused_element %></span>
              <% else %>
                No element focused yet
              <% end %>
            </div>
          </div>

          <div class="text-xs text-gray-500 space-y-1">
            <div>• All elements have proper ARIA labels</div>
            <div>• Focus rings visible for keyboard navigation</div>
            <div>• Screen reader announcements via aria-live</div>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("focus_element", %{"element" => element}, socket) do
    announcement = "Focused on #{element}"
    {:noreply, assign(socket, focused_element: element, announcement: announcement)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
