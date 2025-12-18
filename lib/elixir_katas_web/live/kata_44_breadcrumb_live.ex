defmodule ElixirKatasWeb.Kata44BreadcrumbLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_44_breadcrumb_notes.md")

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:breadcrumbs, [{"Home", ~p"/katas/44-breadcrumb"}])
      |> assign(:current_content, "Home Page")

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    breadcrumbs = build_breadcrumbs(params)
    content = get_content(params)
    {:noreply, assign(socket, breadcrumbs: breadcrumbs, current_content: content)}
  end

  defp build_breadcrumbs(params) do
    base = [{"Home", ~p"/katas/44-breadcrumb"}]
    
    case params do
      %{"section" => section, "page" => page} ->
        base ++ [
          {String.capitalize(section), ~p"/katas/44-breadcrumb?section=#{section}"},
          {String.capitalize(page), ~p"/katas/44-breadcrumb?section=#{section}&page=#{page}"}
        ]
      %{"section" => section} ->
        base ++ [{String.capitalize(section), ~p"/katas/44-breadcrumb?section=#{section}"}]
      _ ->
        base
    end
  end

  defp get_content(params) do
    case params do
      %{"section" => section, "page" => page} ->
        "#{String.capitalize(section)} > #{String.capitalize(page)}"
      %{"section" => section} ->
        String.capitalize(section)
      _ ->
        "Home Page"
    end
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 44: The Breadcrumb" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
           Navigate through sections. Watch the breadcrumb trail update.
        </div>

        <div class="bg-white rounded-lg shadow-sm border">
          <!-- Breadcrumb -->
          <div class="px-6 py-3 bg-gray-50 border-b flex items-center space-x-2 text-sm">
            <%= for {crumb, index} <- Enum.with_index(@breadcrumbs) do %>
              <%= if index > 0 do %>
                <span class="text-gray-400">/</span>
              <% end %>
              <%= if index == length(@breadcrumbs) - 1 do %>
                <span class="text-gray-900 font-medium"><%= elem(crumb, 0) %></span>
              <% else %>
                <.link patch={elem(crumb, 1)} class="text-indigo-600 hover:text-indigo-800">
                  <%= elem(crumb, 0) %>
                </.link>
              <% end %>
            <% end %>
          </div>

          <!-- Content -->
          <div class="p-6">
            <h2 class="text-2xl font-bold mb-4"><%= @current_content %></h2>
            
            <div class="grid grid-cols-3 gap-4">
              <div class="space-y-2">
                <h3 class="font-medium text-sm text-gray-700">Documentation</h3>
                <.link patch={~p"/katas/44-breadcrumb?section=docs"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Docs Section
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=docs&page=guides"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Guides
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=docs&page=api"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  API Reference
                </.link>
              </div>
              
              <div class="space-y-2">
                <h3 class="font-medium text-sm text-gray-700">Community</h3>
                <.link patch={~p"/katas/44-breadcrumb?section=community"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Community Section
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=community&page=forum"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Forum
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=community&page=chat"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Chat
                </.link>
              </div>
              
              <div class="space-y-2">
                <h3 class="font-medium text-sm text-gray-700">Resources</h3>
                <.link patch={~p"/katas/44-breadcrumb?section=resources"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Resources Section
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=resources&page=tutorials"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Tutorials
                </.link>
                <.link patch={~p"/katas/44-breadcrumb?section=resources&page=videos"} class="block p-3 bg-gray-50 hover:bg-gray-100 rounded text-sm">
                  Videos
                </.link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end
end
