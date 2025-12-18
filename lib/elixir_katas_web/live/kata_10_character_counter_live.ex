defmodule ElixirKatasWeb.Kata10CharacterCounterLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_10_character_counter_notes.md")

    {:ok, 
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(text: "Type something...")
     |> assign(limit: 100)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 10: Character Counter" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center justify-center p-8 gap-8">
        <div class="w-full max-w-lg">
          <label class="form-control">
            <div class="label">
              <span class="label-text text-lg font-semibold">Your Bio</span>
              <span class={"label-text-alt font-mono " <> count_class(String.length(@text), @limit)}>
                {String.length(@text)} / {@limit}
              </span>
            </div>
            <textarea 
              phx-keyup="update_text"
              class="textarea textarea-bordered h-40 text-lg leading-relaxed focus:outline-none focus:ring-2 focus:ring-primary transition-all duration-300"
              placeholder="Tell us about yourself"
            >{@text}</textarea>
            <div class="label">
              <span class="label-text-alt text-gray-400">
                {if String.length(@text) > @limit, do: "You have exceeded the limit!", else: "Keep it concise."}
              </span>
            </div>
          </label>

          <div class="mt-8 w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2.5 overflow-hidden">
            <div 
              class={"h-2.5 rounded-full transition-all duration-500 ease-out " <> progress_color(String.length(@text), @limit)} 
              style={"width: #{min((String.length(@text) / @limit) * 100, 100)}%"}
            ></div>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("update_text", %{"value" => value}, socket) do
    {:noreply, assign(socket, text: value)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else 
       {:noreply, socket}
    end
  end

  defp count_class(current, limit) do
    cond do
      current > limit -> "text-error font-bold"
      current >= limit * 0.9 -> "text-warning font-bold"
      true -> "text-gray-500"
    end
  end

  defp progress_color(current, limit) do
    cond do
      current > limit -> "bg-error"
      current >= limit * 0.9 -> "bg-warning"
      true -> "bg-primary"
    end
  end
end
