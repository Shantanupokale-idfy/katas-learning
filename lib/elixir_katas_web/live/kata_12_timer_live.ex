defmodule ElixirKatasWeb.Kata12TimerLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_12_timer_notes.md")

    {:ok, 
     socket
     |> assign(active_tab: "interactive")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(seconds: 60)
     |> assign(running: false)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 12: The Timer" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center justify-center p-8 gap-8 min-h-[400px]">
        <div class="flex flex-col items-center gap-8">
          <div class="countdown font-mono text-8xl text-gray-800 dark:text-gray-100">
            <span style={"--value:#{@seconds};"}></span>
          </div>
          
          <div class="flex gap-4">
             <%= if @running do %>
              <button phx-click="stop" class="btn btn-error btn-lg">Stop</button>
             <% else %>
               <%= if @seconds > 0 do %>
                 <button phx-click="start" class="btn btn-primary btn-lg">Start</button>
               <% end %>
             <% end %>
             
             <button phx-click="reset" class="btn btn-ghost btn-lg">Reset</button>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("start", _, socket) do
    if socket.assigns.running do
      {:noreply, socket}
    else
      Process.send_after(self(), :tick, 1000)
      {:noreply, assign(socket, running: true)}
    end
  end

  def handle_event("stop", _, socket) do
    {:noreply, assign(socket, running: false)}
  end

  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, seconds: 60, running: false)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end

  def handle_info(:tick, socket) do
    if socket.assigns.running and socket.assigns.seconds > 0 do
      Process.send_after(self(), :tick, 1000)
      {:noreply, update(socket, :seconds, &(&1 - 1))}
    else
      {:noreply, assign(socket, running: false)}
    end
  end
end
