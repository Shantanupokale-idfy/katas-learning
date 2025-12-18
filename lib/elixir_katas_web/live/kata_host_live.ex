defmodule ElixirKatasWeb.KataHostLive do
  use ElixirKatasWeb, :live_view
  alias ElixirKatas.Katas.DynamicCompiler
  import ElixirKatasWeb.KataComponents

  def mount(params, session, socket) do
    kata_id = Map.get(params, "kata_id", "01")
    
    user_token = session["user_token"]
    user = 
      if user_token do
        case ElixirKatas.Accounts.get_user_by_session_token(user_token) do
          {user, _token} -> user
          _ -> nil
        end
      end
    
    user_id = if user, do: user.id, else: 0
    
    # 1. Load Source
    base_file = "lib/elixir_katas_web/live/kata_#{kata_id}_hello_world_live.ex" 
    source_code = File.read!(base_file)
    
    # 2. Compile Initial
    {:ok, module} = DynamicCompiler.compile(user_id, "Kata01", source_code)

    # 3. Load Notes
    notes_path = "notes/kata_01_hello_world_notes.md" # hardcoded for PoC
    notes_content = 
        if File.exists?(notes_path), do: File.read!(notes_path), else: "Notes not found."

    {:ok, 
     socket
     |> assign(:dynamic_module, module)
     |> assign(:source_code, source_code)
     |> assign(:user_id, user_id)
     |> assign(:active_tab, "interactive")
     |> assign(:notes_content, notes_content)
     |> assign(:read_only, false) # PoC is always editable
    }
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen w-full">
      <.kata_viewer 
        active_tab={@active_tab}
        title="Kata 01: Hello World"
        source_code={@source_code}
        notes_content={@notes_content}
        read_only={@read_only}
      >
        <div class="h-full w-full">
             <.live_component module={@dynamic_module} id="kata-sandbox" />
        </div>
      </.kata_viewer>
    </div>
    """
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end

  def handle_event("save_source", %{"source" => source}, socket) do
     # 1. Recompile User Code
     case DynamicCompiler.compile(socket.assigns.user_id, "Kata01", source) do
        {:ok, new_module} -> 
            {:noreply, 
             socket
             |> assign(:source_code, source)
             |> assign(:dynamic_module, new_module)
             |> put_flash(:info, "Compiled successfully!")
            }
        {:error, err} ->
            {:noreply, put_flash(socket, :error, "Compilation failed: #{inspect(err)}")}
     end
  end
  
  # Stub for revert if needed
  def handle_event("revert", _, socket), do: {:noreply, socket}
end
