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
      </div>
    </div>
    """
  end
end
