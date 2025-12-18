defmodule ElixirKatasWeb.Kata99CSVExportLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_99_csv_notes.md")

    users = [
      %{id: 1, name: "Alice Smith", role: "Engineer", joined: "2024-01-15"},
      %{id: 2, name: "Bob Jones", role: "Designer", joined: "2024-02-01"},
      %{id: 3, name: "Charlie Brown", role: "Manager", joined: "2024-03-10"},
      %{id: 4, name: "Dana White", role: "Director", joined: "2023-11-20"},
      %{id: 5, name: "Evan Green", role: "Developer", joined: "2024-01-05"}
    ]

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:users, users)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 99: CSV Export" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
          Export table data to CSV file using NimbleCSV
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">
          <div class="flex justify-between items-center mb-6">
            <h3 class="text-lg font-medium">User Data</h3>
            <a 
              href="/exports/csv" 
              class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 flex items-center gap-2 text-sm font-medium"
            >
              <.icon name="hero-arrow-down-tray" class="w-4 h-4" />
              Export CSV
            </a>
          </div>
          
          <div class="overflow-hidden border rounded-lg">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Joined</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <%= for user <- @users do %>
                  <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= user.id %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= user.name %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= user.role %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= user.joined %></td>
                  </tr>
                <% end %>
              </tbody>
            </table>
          </div>
          <p class="mt-4 text-xs text-gray-500">
            Clicking export will trigger a download of this data generated via NimbleCSV.
          </p>
        </div>
      </div>
    </.kata_viewer>
    """
  end



  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
