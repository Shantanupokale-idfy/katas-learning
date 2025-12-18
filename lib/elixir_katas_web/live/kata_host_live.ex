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
    file_source = File.read!(base_file)

    # Check DB for User Version
    {source_code, is_user_author} =
      if user_id != 0 do
         case ElixirKatas.Katas.get_user_kata(user_id, "Kata#{kata_id}") do
            nil -> {file_source, false}
            user_kata -> {user_kata.source_code, true}
         end
      else
         {file_source, false}
      end
    
    # 2. Compile Initial
    # Always recompile if it's the user's custom version to ensure the module is fresh in memory.
    # If it's the default file, we still compile it for the "Hot Seat" (to get a unique module name for this user/session).
    {:ok, module} = DynamicCompiler.compile(user_id, "Kata#{kata_id}", source_code)

    # 3. Load Notes
    notes_path = "notes/kata_01_hello_world_notes.md" # hardcoded for PoC
    notes_content = 
        if File.exists?(notes_path), do: File.read!(notes_path), else: "Notes not found."

    {:ok, 
     socket
     |> assign(:dynamic_module, module)
     |> assign(:source_code, source_code)
     |> assign(:user_id, user_id)
     |> assign(:kata_id, kata_id) # Need this for saving
     |> assign(:active_tab, "interactive")
     |> assign(:notes_content, notes_content)
     |> assign(:read_only, false) # PoC is always editable
     |> assign(:is_user_author, is_user_author)
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
     user_id = socket.assigns.user_id
     kata_id = socket.assigns.kata_id
     kata_name = "Kata#{kata_id}"

     # 1. Recompile User Code
     case DynamicCompiler.compile(user_id, kata_name, source) do
        {:ok, new_module} -> 
            
            # 2. Persist to DB if logged in
            if user_id != 0 do
               ElixirKatas.Katas.save_user_kata(user_id, kata_name, source)
            end

            {:noreply, 
             socket
             |> assign(:source_code, source)
             |> assign(:dynamic_module, new_module)
             |> assign(:is_user_author, true)
             |> put_flash(:info, "Saved & Compiled successfully!")
            }
        {:error, err} ->
            {:noreply, put_flash(socket, :error, "Compilation failed: #{inspect(err)}")}
     end
  end
  
  def handle_event("revert", _, socket) do
     user_id = socket.assigns.user_id
     kata_id = socket.assigns.kata_id
     kata_name = "Kata#{kata_id}"
     
     if user_id != 0 do
       # 1. Delete user version
       ElixirKatas.Katas.delete_user_kata(user_id, kata_name)
       
       # 2. Reload generic version
       base_file = "lib/elixir_katas_web/live/kata_#{kata_id}_hello_world_live.ex" 
       source_code = File.read!(base_file)
       
       # 3. Recompile generic version
       {:ok, module} = DynamicCompiler.compile(user_id, kata_name, source_code)
       
       {:noreply,
        socket
        |> assign(:source_code, source_code)
        |> assign(:dynamic_module, module)
        |> assign(:is_user_author, false)
        |> put_flash(:info, "Reverted to original version!")
       }
     else
        {:noreply, put_flash(socket, :error, "Cannot revert as Guest.")}
     end
  end
end
