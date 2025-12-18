defmodule ElixirKatasWeb.Kata04TogglerLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_04_toggler_notes.md")

    {:ok,
     socket
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     |> assign(show_details: false)
     |> assign(is_active: false)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 04: The Toggler" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="flex flex-col gap-8 max-w-lg mx-auto mt-12 items-center">
        
        <!-- Conditional Rendering Example -->
        <div class="flex flex-col items-center gap-4 w-full">
          <button phx-click="toggle_details" class="btn btn-primary">
            {if @show_details, do: "Hide Details", else: "Show Details"}
          </button>

          <div :if={@show_details} class="alert alert-info shadow-lg animate-fade-in-down">
            <.icon name="hero-information-circle" class="w-6 h-6" />
            <div>
              <h3 class="font-bold">Secret Revealed!</h3>
              <div class="text-xs">You can use standard Elixir <code>if</code> blocks in HEEx.</div>
            </div>
          </div>
        </div>

        <div class="divider"></div>

        <!-- Dynamic Class Example -->
        <div class="flex flex-col items-center gap-4 w-full">
          <h3 class="text-lg font-semibold">Dynamic Styling</h3>
          
          <button 
            phx-click="toggle_active" 
            class={[
              "card w-full shadow-xl transition-all duration-300 cursor-pointer border-2",
              if(@is_active, do: "bg-secondary text-secondary-content scale-105 border-secondary", else: "bg-base-100 hover:bg-base-200 border-base-300")
            ]}
          >
            <div class="card-body items-center text-center">
              <h2 class="card-title">
                {if @is_active, do: "I am ACTIVE!", else: "Click me!"}
              </h2>
              <p>{if @is_active, do: "Look at my cool colors.", else: "I am boring and plain."}</p>
            </div>
          </button>
        </div>

      </div>
    </.kata_viewer>
    """
  end

  def handle_event("toggle_details", _params, socket) do
    {:noreply, update(socket, :show_details, &(!&1))}
  end

  def handle_event("toggle_active", _params, socket) do
    {:noreply, update(socket, :is_active, &(!&1))}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
