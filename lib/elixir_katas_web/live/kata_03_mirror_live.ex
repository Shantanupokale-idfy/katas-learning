defmodule ElixirKatasWeb.Kata03MirrorLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_03_mirror_notes.md")

    {:ok,
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(text: "")}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 03: The Mirror" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col gap-8 max-w-lg mx-auto mt-12">
        <form phx-change="mirror" class="flex flex-col gap-4">
          <label class="form-control w-full">
            <div class="label">
              <span class="label-text">Type something here:</span>
            </div>
            <input 
              type="text" 
              name="text" 
              value={@text} 
              placeholder="Hello..." 
              class="input input-bordered w-full" 
              phx-debounce="100"
              autocomplete="off"
            />
          </label>
        </form>

        <div class="card bg-base-200 shadow-xl">
          <div class="card-body">
            <h2 class="card-title text-sm uppercase text-gray-500">The Mirror Reflection</h2>
            <div class="min-h-[3rem] text-2xl font-serif">
               {if @text == "", do: raw("<span class='italic text-gray-400'>Waiting for input...</span>"), else: @text}
            </div>
            <div class="card-actions justify-end mt-4">
               <div class="badge badge-outline">{String.length(@text)} chars</div>
            </div>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("mirror", %{"text" => text}, socket) do
    {:noreply, assign(socket, text: text)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
