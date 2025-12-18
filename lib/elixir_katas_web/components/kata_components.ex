defmodule ElixirKatasWeb.KataComponents do
  use ElixirKatasWeb, :html

  attr :active_tab, :string, required: true
  attr :title, :string, required: true
  attr :source_code, :string, required: true
  attr :notes_content, :string, required: true
  slot :inner_block, required: true
  
  attr :read_only, :boolean, default: false
  
  def kata_viewer(assigns) do
    ~H"""
    <div class="flex flex-col h-full">
      <div class="flex items-center justify-between border-b border-zinc-200 dark:border-zinc-700 px-4 py-2">
        <h2 class="text-xl font-bold">{@title}</h2>
        
        <div class="flex gap-2 items-center">
          <.tab_button active={@active_tab == "notes"} phx-click="set_tab" phx-value-tab="notes">
            Description
          </.tab_button>
          <.tab_button active={@active_tab == "interactive"} phx-click="set_tab" phx-value-tab="interactive">
            Interactive
          </.tab_button>
          <.tab_button active={@active_tab == "source"} phx-click="set_tab" phx-value-tab="source">
            Source Code
          </.tab_button>
          
          <%= if @read_only do %>
             <span class="ml-2 px-2 py-1 text-xs font-semibold bg-gray-200 text-gray-700 rounded-full dark:bg-gray-700 dark:text-gray-300">
               Read Only
             </span>
          <% else %>
             <%= if @active_tab == "source" do %>
                <button phx-click="revert" data-confirm="Are you sure? This will discard your changes and restore the original code." class="ml-2 btn btn-xs btn-outline btn-error">
                  Revert to Original
                </button>
             <% end %>
          <% end %>
        </div>
      </div>

      <div class="flex-1 overflow-auto p-4">
        <%= case @active_tab do %>
          <% "interactive" -> %>
            {render_slot(@inner_block)}
          
          <% "source" -> %>
            <div class="mockup-code w-full p-0 overflow-hidden relative">
              <div 
                id={"editor-#{@title |> slugify()}"}
                phx-hook="CodeEditor" 
                data-content={@source_code}
                data-read-only={"#{@read_only}"}
                phx-update="ignore"
                class="w-full text-sm"
              ></div>
            </div>

          <% "notes" -> %>
            <div class="prose dark:prose-invert max-w-none">
              {raw Earmark.as_html!(@notes_content)}
            </div>
        <% end %>
      </div>
    </div>
    """
  end

  attr :active, :boolean, default: false
  attr :rest, :global
  slot :inner_block

  def tab_button(assigns) do
    ~H"""
    <button
      class={[
        "px-4 py-2 rounded-lg text-sm font-medium transition-colors",
        if(@active, do: "bg-primary text-white", else: "hover:bg-zinc-100 dark:hover:bg-zinc-800")
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :path, :string, required: true

  def kata_card(assigns) do
    ~H"""
    <.link navigate={@path} class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
      <div class="flex items-center mb-4">
        <span class="w-3 h-3 rounded-full bg-indigo-600 mr-3"></span>
        <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">{@title}</h2>
      </div>
      <p class="text-gray-600 dark:text-gray-400">
        {@description}
      </p>
    </.link>
    """
  end
  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/\s+/, "-")
  end
end
