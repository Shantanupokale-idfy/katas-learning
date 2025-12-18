defmodule ElixirKatasWeb.Kata89ChartjsLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_89_chart_notes.md")

    chart_data = %{
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        %{
          label: "Sales",
          data: [65, 59, 80, 81, 56, 55, 40],
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          borderWidth: 1
        }
      ]
    }

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:chart_data, chart_data)

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
          Integration with Chart.js using JS Hooks and server-side data updates
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">
          <div class="flex justify-between items-center mb-6">
            <h3 class="text-lg font-medium">Monthly Sales</h3>
            <button 
              phx-click="randomize" 
              class="px-4 py-2 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700 transition"
            >
              Randomize Data
            </button>
          </div>
          
          <div class="relative w-full h-[400px]">
             <canvas 
               id="myChart" 
               phx-hook="ChartJS" 
               data-chart-data={Jason.encode!(@chart_data)}
               phx-update="ignore"
             >
             </canvas>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("randomize", _, socket) do
    data = Enum.map(1..7, fn _ -> :rand.uniform(100) end)
    
    # Update the map, not the socket path directly for variables
    current_data = socket.assigns.chart_data
    new_chart_data = 
      put_in(current_data[:datasets], [
        %{
          label: "Sales",
          data: data,
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          borderWidth: 1
        }
      ])

    {:noreply, 
      socket 
      |> assign(:chart_data, new_chart_data)
      |> push_event("update-chart", new_chart_data)
    }
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
