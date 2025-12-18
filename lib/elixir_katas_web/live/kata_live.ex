defmodule ElixirKatasWeb.KataLive do
  defmacro __using__(_opts) do
    quote do
      use ElixirKatasWeb, :live_view
      import ElixirKatasWeb.KataComponents

      def mount(_params, _session, socket) do
        source_code = File.read!(__ENV__.file)
        # Assumes a consistent naming convention for notes
        # limit to basename to avoid path traversal or complex logic, though for now we can infer from module name or just hardcode in the calling module if needed.
        # But to be generic, let's try to infer or let the specific kata override mount if it's too complex.
        
        # Actually, let's just do the basics here and allow overriding.
        # For the notes file, we can guess it based on the current file path.
        # e.g. lib/.../kata_01_hello_world_live.ex -> notes/kata_01_hello_world_notes.md
        
        current_file = __ENV__.file
        basename = Path.basename(current_file, "_live.ex")
        notes_path = "notes/#{basename}_notes.md"
        
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
         |> assign_defaults()}
      end

      def handle_params(params, url, socket) do
        tab = params["tab"] || "notes"
        
        # safely parse key parts
        path = URI.parse(url).path
        
        {:noreply, 
         socket
         |> assign(active_tab: tab)
         |> assign(current_path: path)}
      end

      # Allow overriding assign_defaults for generic setup
      defp assign_defaults(socket), do: socket

      def handle_event("set_tab", %{"tab" => tab}, socket) do
        {:noreply, push_patch(socket, to: socket.assigns.current_path <> "?tab=#{tab}")}
      end

      def handle_event("save_source", %{"source" => source}, socket) do
        case Code.string_to_quoted(source) do
          {:ok, _quoted} ->
            if Application.get_env(:elixir_katas, :env) != :test do
              File.write!(__ENV__.file, source)
            else
              IO.puts("Test mode: Skipping file write to #{__ENV__.file}")
            end
            {:noreply, put_flash(socket, :info, "Source saved!")}

          {:error, {line, error, _token}} ->
            # Syntax error
            msg = "Syntax error on line #{line}: #{error}"
            {:noreply, put_flash(socket, :error, msg)}
        end
      end
      
      defoverridable mount: 3, assign_defaults: 1
    end
  end
end
