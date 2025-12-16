defmodule ElixirKatasWeb.Kata02CounterLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("kata_02_counter_notes.md")

    {:ok,
     socket
     |> assign(active_tab: "interactive")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(count: 0)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 02: Counter" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col items-center justify-center min-h-[50vh] gap-8">
        <div class="text-9xl font-bold font-mono text-primary">
          {@count}
        </div>
        
        <div class="flex gap-4">
          <button phx-click="dec" class="btn btn-lg btn-circle btn-outline">
            <.icon name="hero-minus" class="w-8 h-8" />
          </button>
          
          <button phx-click="reset" class="btn btn-lg btn-outline border-2 font-bold">
            RESET
          </button>
          
          <button phx-click="inc" class="btn btn-lg btn-circle btn-primary text-white">
            <.icon name="hero-plus" class="w-8 h-8" />
          </button>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, count: 0)}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
