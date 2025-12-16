defmodule ElixirKatasWeb.Kata89ChartjsLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_89_chart_notes.md")

    socket =
      socket
      |> assign(active_tab: "interactive")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:demo_active, false)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 89: Chart.js" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
          Chart display with sample data
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">
          <h3 class="text-lg font-medium mb-4">Chart.js</h3>
          
          <div class="space-y-4">
            <button 
              phx-click="toggle_demo"
              class="px-6 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700"
            >
              {%= if @demo_active, do: "Hide Demo", else: "Show Demo" %}
            </button>

            {%= if @demo_active do %}
              <div class="p-4 bg-blue-50 border border-blue-200 rounded">
                <div class="font-medium mb-2">Chart.js Demo</div>
                <div class="text-sm text-gray-700">
                  This demonstrates data visualization. In a real implementation, 
                  this would include full chart.js functionality with proper 
                  JavaScript integration.
                </div>
                <div class="mt-3 text-xs text-gray-500">
                  Check the Notes and Source Code tabs for implementation details.
                </div>
              </div>
            {% end %}
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("toggle_demo", _, socket) do
    {:noreply, assign(socket, :demo_active, !socket.assigns.demo_active)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
