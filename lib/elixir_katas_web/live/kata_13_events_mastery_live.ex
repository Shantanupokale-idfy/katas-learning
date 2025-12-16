defmodule ElixirKatasWeb.Kata13EventsMasteryLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_13_events_mastery_notes.md")

    {:ok, 
     socket
     |> assign(active_tab: "interactive")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(logs: [])}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 13: Events Mastery" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col md:flex-row h-full p-4 gap-4">
        <div class="w-full md:w-1/2 flex flex-col gap-8 justify-center items-center p-8 bg-gray-50 dark:bg-gray-800 rounded-lg">
          <input 
            type="text" 
            placeholder="Focus, Blur, or Type here..." 
            class="input input-bordered w-full max-w-xs text-lg"
            phx-focus="focus_event"
            phx-blur="blur_event"
            phx-keyup="keyup_event"
          />
          <div class="text-sm text-gray-500">
            Interact with the input above to see events logged on the right.
          </div>
        </div>

        <div class="w-full md:w-1/2 bg-black text-green-400 font-mono p-4 rounded-lg overflow-y-auto h-96 shadow-inner">
          <div class="flex justify-between items-center mb-4 border-b border-green-800 pb-2">
            <span class="font-bold">Event Log</span>
            <button phx-click="clear" class="text-xs hover:text-white underline">Clear</button>
          </div>
          <div class="flex flex-col-reverse">
             <%= for {event, time} <- @logs do %>
               <div class="mb-1">
                 <span class="opacity-50">[{time}]</span> {event}
               </div>
             <% end %>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("focus_event", _params, socket) do
    log(socket, "Input Focused")
  end

  def handle_event("blur_event", _params, socket) do
    log(socket, "Input Blurred")
  end

  def handle_event("keyup_event", %{"key" => key}, socket) do
    log(socket, "Key Up: #{key}")
  end

  def handle_event("clear", _, socket) do
    {:noreply, assign(socket, logs: [])}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end

  defp log(socket, message) do
    timestamp = Time.to_string(Time.utc_now()) |> String.slice(0..7)
    new_log = {message, timestamp}
    {:noreply, update(socket, :logs, fn logs -> [new_log | logs] |> Enum.take(20) end)}
  end
end
