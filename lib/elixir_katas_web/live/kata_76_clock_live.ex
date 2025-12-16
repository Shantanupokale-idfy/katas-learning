defmodule ElixirKatasWeb.Kata76ClockLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_76_clock_notes.md")

    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket =
      socket
      |> assign(active_tab: "interactive")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:current_time, DateTime.utc_now())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 76: The Clock" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
          Server-driven clock that updates every second.
        </div>

        <div class="bg-white p-8 rounded-lg shadow-sm border text-center">
          <div class="text-6xl font-bold text-indigo-600 mb-4">
            <%= Calendar.strftime(@current_time, "%H:%M:%S") %>
          </div>
          <div class="text-xl text-gray-600">
            <%= Calendar.strftime(@current_time, "%A, %B %d, %Y") %>
          </div>
          <div class="mt-4 text-sm text-gray-500">
            Updates automatically every second
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, assign(socket, :current_time, DateTime.utc_now())}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
