defmodule ElixirKatasWeb.Router do
  use ElixirKatasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ElixirKatasWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirKatasWeb do
    pipe_through :browser

    get "/", PageController, :home
    live_session :default, layout: {ElixirKatasWeb.Layouts, :app} do
      live "/katas", KatasIndexLive
      live "/katas/01-hello-world", Kata01HelloWorldLive
      live "/katas/02-counter", Kata02CounterLive
      live "/katas/03-mirror", Kata03MirrorLive
      live "/katas/04-toggler", Kata04TogglerLive
      live "/katas/05-color-picker", Kata05ColorPickerLive
      live "/katas/06-resizer", Kata06ResizerLive
      live "/katas/07-spoiler", Kata07SpoilerLive
      live "/katas/08-accordion", Kata08AccordionLive
      live "/katas/09-tabs", Kata09TabsLive
      live "/katas/10-character-counter", Kata10CharacterCounterLive
      live "/katas/11-stopwatch", Kata11StopwatchLive
      live "/katas/12-timer", Kata12TimerLive
      live "/katas/13-events-mastery", Kata13EventsMasteryLive
      live "/katas/14-keybindings", Kata14KeybindingsLive
      live "/katas/15-calculator", Kata15CalculatorLive
      live "/katas/16-list", Kata16ListLive
      live "/katas/17-remover", Kata17RemoverLive
      live "/katas/18-editor", Kata18EditorLive
      live "/katas/19-filter", Kata19FilterLive
      live "/katas/20-sorter", Kata20SorterLive
    live "/katas/21-paginator", Kata21PaginatorLive
    live "/katas/22-highlighter", Kata22HighlighterLive
    live "/katas/23-multi-select", Kata23MultiSelectLive
    live "/katas/24-grid", Kata24GridLive
    live "/katas/25-tree", Kata25TreeLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirKatasWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:elixir_katas, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ElixirKatasWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
