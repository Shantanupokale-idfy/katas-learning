defmodule ElixirKatasWeb.KataLive do
  defmacro __using__(_opts) do
    quote do
      use ElixirKatasWeb, :live_view
      import ElixirKatasWeb.KataComponents

      def mount(_params, session, socket) do
        source_code_file = __ENV__.file
        basename = Path.basename(source_code_file, "_live.ex")
        notes_path = "notes/#{basename}_notes.md"
        kata_name = basename # e.g. "kata_01_hello_world"
        
        # Load User
        user_token = session["user_token"]
        current_user = 
          if user_token do
             case ElixirKatas.Accounts.get_user_by_session_token(user_token) do
                {user, _token} -> user
                _ -> nil
             end
          end

        # Load Source Code
        # Strategy:
        # 1. If Guest: Read file. Read-only mode.
        # 2. If User:
        #    a. Check DB for UserKata.
        #    b. If exists: Write DB content to file (Hot Seat!). Set source_code = DB content.
        #    c. If not exists: Read file. Set source_code = File content.
        
        {source_code, read_only} = 
          if current_user do
             case ElixirKatas.Katas.get_user_kata(current_user.id, kata_name) do
               nil -> 
                 # First time user, or just using default.
                 # Ensure we have a clean slate if we want? 
                 # For now, just read what's on disk.
                 # Ideally we should backup here if we are paranoid, but we'll do it on save.
                 {File.read!(source_code_file), false}
               
               user_kata ->
                 # Restore user's session to the hot seat
                 if Application.get_env(:elixir_katas, :env) != :test do
                   if File.read!(source_code_file) != user_kata.source_code do
                     File.write!(source_code_file, user_kata.source_code)
                   end
                 end
                 {user_kata.source_code, false}
             end
          else
             {File.read!(source_code_file), true}
          end

        notes_content = 
          if File.exists?(notes_path) do
             File.read!(notes_path)
          else
             "# Notes not found for #{basename}"
          end
        
        {:ok, 
         socket
         |> assign(active_tab: "notes")
         |> assign(source_code: source_code)
         |> assign(notes_content: notes_content)
         |> assign(current_user: current_user)
         |> assign(read_only: read_only)
         |> assign(kata_name: kata_name)
         |> assign_defaults()}
      end

      # Allow overriding assign_defaults for generic setup
      defp assign_defaults(socket), do: socket

      def handle_params(params, url, socket) do
        tab = params["tab"] || "notes"
        
        # safely parse key parts
        path = URI.parse(url).path
        
        {:noreply, 
         socket
         |> assign(active_tab: tab)
         |> assign(current_path: path)}
      end

      def handle_event("set_tab", %{"tab" => tab}, socket) do
        {:noreply, push_patch(socket, to: socket.assigns.current_path <> "?tab=#{tab}")}
      end

      def handle_event("save_source", %{"source" => source}, socket) do
        if socket.assigns.read_only do
           {:noreply, put_flash(socket, :error, "You must be logged in to edit.")}
        else
          case Code.string_to_quoted(source) do
            {:ok, _quoted} ->
              # 1. Backup if needed (simple check: does .bak exist?)
              source_file = __ENV__.file
              bak_file = source_file <> ".bak"
              
              if !File.exists?(bak_file) do
                 File.cp!(source_file, bak_file)
              end
              
              # 2. Write to File (Hot Seat)
              if Application.get_env(:elixir_katas, :env) != :test do
                File.write!(source_file, source)
              end
              
              # 3. Save to DB
              ElixirKatas.Katas.save_user_kata(socket.assigns.current_user.id, socket.assigns.kata_name, source)
              
              {:noreply, put_flash(socket, :info, "Source saved!")}
  
            {:error, {line, error, _token}} ->
              # Syntax error
              msg = "Syntax error on line #{line}: #{error}"
              {:noreply, put_flash(socket, :error, msg)}
          end
        end
      end
      
      def handle_event("revert", _params, socket) do
         if socket.assigns.read_only do
            {:noreply, put_flash(socket, :error, "Read-only mode.")}
         else
            source_file = __ENV__.file
            bak_file = source_file <> ".bak"
            
            if File.exists?(bak_file) do
               # 1. Restore from backup
               original_source = File.read!(bak_file)
               
               if Application.get_env(:elixir_katas, :env) != :test do
                 File.write!(source_file, original_source)
               end
               
               # 2. Delete from DB
               ElixirKatas.Katas.delete_user_kata(socket.assigns.current_user.id, socket.assigns.kata_name)
               
               # 3. Force reload/redirect to clear state? 
               # Since file changed, LiveReload currently handles it, but let's push a flash.
               
               {:noreply, 
                 socket
                 |> put_flash(:info, "Reverted to original!")
                 |> push_event("save_source", %{source: original_source}) # Update frontend editor content? No, easier to just let reload happen or assign source_code. 
                 # Actually, modifying file triggers reload, so assign is moot if reload happens fast.
                 # But let's verify.
               } 
            else
               {:noreply, put_flash(socket, :error, "No original version found to revert to.")} 
            end
         end
      end
      
      defoverridable mount: 3, assign_defaults: 1
    end
  end
end
