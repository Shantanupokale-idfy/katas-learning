defmodule ElixirKatasWeb.KatasIndexLive do
  use ElixirKatasWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto py-8">
      <h1 class="text-3xl font-bold mb-8 text-gray-900 dark:text-white">
        Welcome to Elixir Katas
      </h1>
      <p class="text-lg text-gray-600 dark:text-gray-300 mb-8">
        Select a kata from the sidebar or the list below to begin your journey.
      </p>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <.link navigate="/katas/01-hello-world" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-green-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">01 - Hello World</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Your first step into Phoenix LiveView. Learn the basics of rendering and event handling.
          </p>
        </.link>

        <.link navigate="/katas/02-counter" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-blue-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">02 - Counter</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Master state management. Build a counter with increment, decrement, and reset functionality.
          </p>
        </.link>

        <.link navigate="/katas/03-mirror" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-purple-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">03 - The Mirror</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Form bindings and real-time updates. mirroring input text instantly to the UI.
          </p>
        </.link>

        <.link navigate="/katas/04-toggler" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-orange-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">04 - The Toggler</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Learn conditional rendering (`if`) and how to switch CSS classes dynamically based on state.
          </p>
        </.link>

        <.link navigate="/katas/05-color-picker" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-pink-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">05 - The Color Picker</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Manage multiple state values (`r, g, b`) and apply inline styles dynamically.
          </p>
        </.link>

        <.link navigate="/katas/06-resizer" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-teal-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">06 - The Resizer</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Learn to bind integer state to CSS `width` and `height` properties.
          </p>
        </.link>

        <.link navigate="/katas/07-spoiler" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-yellow-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">07 - The Spoiler</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Create a "click to reveal" component using boolean state and CSS blur filters.
          </p>
        </.link>

        <.link navigate="/katas/08-accordion" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-cyan-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">08 - The Accordion</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Manage a collection of items where only one can be active at a time (`active_id`).
          </p>
        </.link>
        <.link navigate="/katas/09-tabs" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-indigo-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">09 - The Tabs</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Switch content based on active tab state.
          </p>
        </.link>

        <.link navigate="/katas/10-character-counter" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-red-500 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">10 - Character Counter</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Real-time string length calculation with limit validation and visual feedback.
          </p>
        </.link>
        <.link navigate="/katas/11-stopwatch" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-blue-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">11 - The Stopwatch</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            A server-driven timer using process messages and interval handling.
          </p>
        </.link>

        <.link navigate="/katas/12-timer" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-orange-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">12 - The Timer</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Countdown timer with start/stop/reset and auto-termination.
          </p>
        </.link>

        <.link navigate="/katas/13-events-mastery" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-green-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">13 - Events Mastery</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Explore focus, blur, and keyup events with real-time logging.
          </p>
        </.link>

        <.link navigate="/katas/14-keybindings" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-purple-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">14 - Keybindings</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Global window keyboard shortcuts with <code>phx-window-keydown</code>.
          </p>
        </.link>

        <.link navigate="/katas/15-calculator" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-gray-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">15 - The Calculator</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Complex state management simulating a real calculator.
          </p>
        </.link>

        <.link navigate="/katas/16-list" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-indigo-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">16 - The List</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Render a list and append new items.
          </p>
        </.link>

        <.link navigate="/katas/17-remover" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-red-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">17 - The Remover</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Remove specific items from a list by ID.
          </p>
        </.link>

        <.link navigate="/katas/18-editor" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-yellow-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">18 - The Editor</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Inline editing of list items.
          </p>
        </.link>

        <.link navigate="/katas/19-filter" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-cyan-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">19 - The Filter</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Real-time client-side filtering of data.
          </p>
        </.link>

        <.link navigate="/katas/20-sorter" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-teal-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">20 - The Sorter</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Sort a table by column headers (asc/desc).
          </p>
        </.link>
        <.link navigate="/katas/21-paginator" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-purple-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">21 - The Paginator</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Simple offset-based pagination Logic.
          </p>
        </.link>

        <.link navigate="/katas/22-highlighter" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-yellow-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">22 - The Highlighter</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Highlighting search terms within text.
          </p>
        </.link>

        <.link navigate="/katas/23-multi-select" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-blue-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">23 - The Multi-Select</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Selecting multiple items from a list with MapSet.
          </p>
        </.link>

        <.link navigate="/katas/24-grid" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-cyan-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">24 - The Grid</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Rendering data in a responsive grid layout.
          </p>
        </.link>

        <.link navigate="/katas/25-tree" class="card bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-shadow border border-gray-200 dark:border-gray-700 p-6 rounded-lg group">
          <div class="flex items-center mb-4">
            <span class="w-3 h-3 rounded-full bg-indigo-600 mr-3"></span>
            <h2 class="text-xl font-semibold group-hover:text-primary transition-colors">25 - The Tree</h2>
          </div>
          <p class="text-gray-600 dark:text-gray-400">
            Recursive rendering of nested data structures.
          </p>
        </.link>
      </div>
    </div>
    """
  end
end
