defmodule ElixirKatasWeb.Kata01HelloWorldLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_01_hello_world_notes.md")
    
    {:ok, 
     socket
     |> assign(clicked: false)
     |> assign(active_tab: "notes")
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 01: Hello World" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="prose dark:prose-invert">
        <h1>Kata 01: Hello World</h1>
        <p>Welcome to your first Elixir LiveView Kata!</p>
        
        <div class="mockup-code">
          <pre data-prefix="$"><code>iex</code></pre> 
          <pre data-prefix=">"><code>IO.puts("Hello World")</code></pre> 
          <pre data-prefix="" class="text-success"><code>Hello World</code></pre>
        </div>

        <div class="mt-8 flex gap-4">
          <button phx-click="toggle" class="btn btn-primary">
            {if @clicked, do: "You clicked me!", else: "Click me!"}
          </button>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("toggle", _params, socket) do
    {:noreply, update(socket, :clicked, &(!&1))}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
