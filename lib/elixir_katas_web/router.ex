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
    live "/katas/26-text-input", Kata26TextInputLive
    live "/katas/27-checkbox", Kata27CheckboxLive
    live "/katas/28-radio-buttons", Kata28RadioButtonsLive
    live "/katas/29-select", Kata29SelectLive
    live "/katas/30-multi-select-form", Kata30MultiSelectFormLive
    live "/katas/31-dependent-inputs", Kata31DependentInputsLive
    live "/katas/32-comparison-validation", Kata32ComparisonValidationLive
    live "/katas/33-formats", Kata33FormatsLive
    live "/katas/34-live-feedback", Kata34LiveFeedbackLive
    live "/katas/35-form-restoration", Kata35FormRestorationLive
    live "/katas/36-debounce", Kata36DebounceLive
    live "/katas/37-wizard", Kata37WizardLive
    live "/katas/38-tag-input", Kata38TagInputLive
    live "/katas/39-rating", Kata39RatingLive
    live "/katas/40-uploads", Kata40UploadsLive
    live "/katas/41-url-params", Kata41UrlParamsLive
    live "/katas/42-path-params/:id", Kata42PathParamsLive
    live "/katas/43-navbar", Kata43NavbarLive
    live "/katas/44-breadcrumb", Kata44BreadcrumbLive
    live "/katas/45-tabs-url", Kata45TabsUrlLive
    live "/katas/46-search-url", Kata46SearchUrlLive
    live "/katas/47-protected", Kata47ProtectedLive
    live "/katas/48-redirects", Kata48RedirectsLive
    live "/katas/49-translator", Kata49TranslatorLive
    live "/katas/50-components", Kata50ComponentsLive
    live "/katas/51-card", Kata51CardLive
    live "/katas/52-button", Kata52ButtonLive
    live "/katas/53-icon", Kata53IconLive
    live "/katas/54-modal", Kata54ModalLive
    live "/katas/55-slideover", Kata55SlideoverLive
    live "/katas/56-tooltip", Kata56TooltipLive
    live "/katas/57-dropdown", Kata57DropdownLive
    live "/katas/58-flash", Kata58FlashLive
    live "/katas/59-skeleton", Kata59SkeletonLive
    live "/katas/60-progress", Kata60ProgressLive
    live "/katas/61-stateful", Kata61StatefulLive
    live "/katas/62-component-id", Kata62ComponentIdLive
    live "/katas/63-send-update", Kata63SendUpdateLive
    live "/katas/64-send-self", Kata64SendSelfLive
    live "/katas/65-child-parent", Kata65ChildParentLive
    live "/katas/66-sibling", Kata66SiblingLive
    live "/katas/67-lazy", Kata67LazyLive
    live "/katas/68-changesets", Kata68ChangesetsLive
    live "/katas/69-crud", Kata69CrudLive
    live "/katas/70-optimistic", Kata70OptimisticLive
    live "/katas/71-streams", Kata71StreamsLive
    live "/katas/72-infinite-scroll", Kata72InfiniteScrollLive
    live "/katas/73-stream-insert-delete", Kata73StreamInsertDeleteLive
    live "/katas/74-stream-reset", Kata74StreamResetLive
    live "/katas/75-bulk-actions", Kata75BulkActionsLive
    live "/katas/76-clock", Kata76ClockLive
    live "/katas/77-ticker", Kata77TheTickerLive
    live "/katas/78-chat", Kata78ChatRoomLive
    live "/katas/79-typing", Kata79TypingIndicatorLive
    live "/katas/80-presence", Kata80PresenceListLive
    live "/katas/81-cursor", Kata81LiveCursorLive
    live "/katas/82-notifications", Kata82DistributedNotificationsLive
    live "/katas/83-game", Kata83TheGameStateLive
    live "/katas/84-focus", Kata84AccessibleFocusLive
    live "/katas/85-scroll", Kata85ScrollToBottomLive
    live "/katas/86-clipboard", Kata86ClipboardCopyLive
    live "/katas/87-storage", Kata87LocalStorageLive
    live "/katas/88-theme", Kata88ThemeSwitcherLive
    live "/katas/89-chart", Kata89ChartJsLive
    live "/katas/90-map", Kata90MapboxLive
    live "/katas/91-masked", Kata91MaskedInputLive
    live "/katas/92-dropzone", Kata92FileDropzoneLive
    live "/katas/93-sortable", Kata93SortableListLive
    live "/katas/94-audio", Kata94AudioPlayerLive
    live "/katas/95-async", Kata95AsyncAssignsLive
    live "/katas/96-uploads", Kata96FileUploadsLive
    live "/katas/97-images", Kata97ImageProcessingLive
    live "/katas/98-pdf", Kata98PDFGenerationLive
    live "/katas/99-csv", Kata99CSVExportLive
    live "/katas/100-error", Kata100ErrorBoundaryLive
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
