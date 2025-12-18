defmodule ElixirKatasWeb.Kata32ComparisonValidationLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_32_comparison_validation_notes.md")

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:form, to_form(%{"password" => "", "confirmation" => ""}))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 32: Comparison Validation" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-lg mx-auto">
        <div class="mb-6 text-sm text-gray-500">
           Validating that two inputs match (e.g. Password Confirmation).
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">
          <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-6">
            
            <div>
              <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
              <div class="mt-1">
                <input
                  type="password"
                  name="password"
                  id="password"
                  value={@form[:password].value}
                  class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                />
              </div>
            </div>

            <div>
              <label for="confirmation" class="block text-sm font-medium text-gray-700">Confirm Password</label>
              <div class="mt-1">
                <input
                  type="password"
                  name="confirmation"
                  id="confirmation"
                  value={@form[:confirmation].value}
                  class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border"
                />
              </div>
              
              <!-- Manual Error Rendering -->
              <%= for error <- @form[:confirmation].errors do %>
                 <p class="mt-2 text-sm text-red-600">
                   <%= local_translate_error(error) %>
                 </p>
              <% end %>
            </div>

            <div>
              <button
                type="submit"
                disabled={@form.errors != [] || @form[:password].value == ""}
                class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:bg-gray-300 disabled:cursor-not-allowed"
              >
                Change Password
              </button>
            </div>
          </.form>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("validate", params, socket) do
    password = params["password"]
    confirmation = params["confirmation"]
    
    errors = 
      if confirmation != "" and password != confirmation do
        [confirmation: {"Passwords do not match", []}] # Format expected by Phoenix.HTML.Form
      else
        []
      end

    {:noreply, assign(socket, :form, to_form(params, errors: errors))}
  end

  def handle_event("save", params, socket) do
    {:noreply, 
     socket
     |> put_flash(:info, "Password updated successfully!")
     |> assign(:form, to_form(%{"password" => "", "confirmation" => ""}))}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
  
  # Helper to render error tuple
  defp local_translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
