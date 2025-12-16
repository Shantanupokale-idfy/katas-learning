defmodule ElixirKatasWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use ElixirKatasWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"



  def app(assigns) do
    ~H"""
    <div class="flex h-screen bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-gray-100 font-sans">
      <!-- Sidebar -->
      <div class="w-64 flex-shrink-0 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 flex flex-col" data-layout-source="custom-app">
        <div class="h-16 flex items-center px-6 border-b border-gray-200 dark:border-gray-700">
          <span class="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-purple-600 to-pink-600">
            Elixir Katas
          </span>
        </div>
        <div class="flex-1 overflow-y-auto p-4" phx-hook="ScrollPosition" data-scroll-key="sidebar-nav" id="sidebar-nav">
          <nav class="space-y-1">
            <a href="/" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md bg-purple-50 dark:bg-purple-900/20 text-purple-700 dark:text-purple-300">
              <.icon name="hero-home" class="mr-3 h-5 w-5 text-purple-600 dark:text-purple-400" />
              Home
            </a>
            
            <div class="mt-8">
              <h3 class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-wider">
                Learning Logic
              </h3>
              <div class="mt-2 space-y-1 pl-2">
                 <!-- Example Kata Link -->
                 <.link navigate="/katas/01-hello-world" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   01 - Hello World
                 </.link>
                 <.link navigate="/katas/02-counter" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-400"></span>
                   02 - Counter
                 </.link>
                 <.link navigate="/katas/03-mirror" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-400"></span>
                   03 - The Mirror
                 </.link>
                 <.link navigate="/katas/04-toggler" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-400"></span>
                   04 - The Toggler
                 </.link>
                 <.link navigate="/katas/05-color-picker" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-400"></span>
                   05 - Color Picker
                 </.link>
                 <.link navigate="/katas/06-resizer" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-teal-400"></span>
                   06 - The Resizer
                 </.link>
                 <.link navigate="/katas/07-spoiler" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-400"></span>
                   07 - The Spoiler
                 </.link>
                 <.link navigate="/katas/08-accordion" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-400"></span>
                   08 - The Accordion
                 </.link>
                 <.link navigate="/katas/09-tabs" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-400"></span>
                   09 - The Tabs
                 </.link>
                 <.link navigate="/katas/10-character-counter" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-400"></span>
                   10 - Character Counter
                 </.link>
                 <.link navigate="/katas/11-stopwatch" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-400"></span>
                   11 - The Stopwatch
                 </.link>
                 <.link navigate="/katas/12-timer" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-400"></span>
                   12 - The Timer
                 </.link>
                 <.link navigate="/katas/13-events-mastery" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   13 - Events Mastery
                 </.link>
                 <.link navigate="/katas/14-keybindings" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-400"></span>
                   14 - Keybindings
                 </.link>
                 <.link navigate="/katas/15-calculator" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-gray-400"></span>
                   15 - The Calculator
                 </.link>
                 <.link navigate="/katas/16-list" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-400"></span>
                   16 - The List
                 </.link>
                 <.link navigate="/katas/17-remover" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-400"></span>
                   17 - The Remover
                 </.link>
                 <.link navigate="/katas/18-editor" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-400"></span>
                   18 - The Editor
                 </.link>
                 <.link navigate="/katas/19-filter" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-400"></span>
                   19 - The Filter
                 </.link>
                 <.link navigate="/katas/20-sorter" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-teal-400"></span>
                   20 - The Sorter
                 </.link>
                 <.link navigate="/katas/21-paginator" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-400"></span>
                   21 - The Paginator
                 </.link>
                 <.link navigate="/katas/22-highlighter" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-400"></span>
                   22 - The Highlighter
                 </.link>
                 <.link navigate="/katas/23-multi-select" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-400"></span>
                   23 - The Multi-Select
                 </.link>
                 <.link navigate="/katas/24-grid" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-400"></span>
                   24 - The Grid
                 </.link>
                 <.link navigate="/katas/25-tree" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-400"></span>
                   25 - The Tree
                 </.link>
                 <.link navigate="/katas/26-text-input" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   26 - The Text Input
                 </.link>
                 <.link navigate="/katas/27-checkbox" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-400"></span>
                   27 - The Checkbox
                 </.link>
                 <.link navigate="/katas/28-radio-buttons" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-400"></span>
                   28 - Radio Buttons
                 </.link>
                 <.link navigate="/katas/29-select" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   29 - The Select
                 </.link>
                 <.link navigate="/katas/30-multi-select-form" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-400"></span>
                   30 - Multi-Select Form
                 </.link>
                 <.link navigate="/katas/31-dependent-inputs" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-400"></span>
                   31 - Dependent Inputs
                 </.link>
                 <.link navigate="/katas/32-comparison-validation" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-400"></span>
                   32 - Comparison Validation
                 </.link>
                 <.link navigate="/katas/33-formats" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-400"></span>
                   33 - Formats
                 </.link>
                 <.link navigate="/katas/34-live-feedback" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   34 - Live Feedback
                 </.link>
                 <.link navigate="/katas/35-form-restoration" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-400"></span>
                   35 - Form Restoration
                 </.link>
                 <.link navigate="/katas/36-debounce" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-400"></span>
                   36 - Debounce
                 </.link>
                 <.link navigate="/katas/37-wizard" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-400"></span>
                   37 - The Wizard
                 </.link>
                 <.link navigate="/katas/38-tag-input" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-400"></span>
                   38 - The Tag Input
                 </.link>
                 <.link navigate="/katas/39-rating" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-400"></span>
                   39 - The Rating Input
                 </.link>
                 <.link navigate="/katas/40-uploads" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-400"></span>
                   40 - File Uploads
                  </.link>
                 <.link navigate="/katas/41-url-params" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-500"></span>
                   41 - URL Params
                 </.link>
                 <.link navigate="/katas/42-path-params/1" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-500"></span>
                   42 - Path Params
                 </.link>
                 <.link navigate="/katas/43-navbar" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-500"></span>
                   43 - The Nav Bar
                 </.link>
                 <.link navigate="/katas/44-breadcrumb" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-500"></span>
                   44 - The Breadcrumb
                 </.link>
                 <.link navigate="/katas/45-tabs-url" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-500"></span>
                   45 - Tabs with URL
                 </.link>
                 <.link navigate="/katas/46-search-url" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-500"></span>
                   46 - Search with URL
                 </.link>
                 <.link navigate="/katas/47-protected" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-500"></span>
                   47 - Protected Routes
                 </.link>
                 <.link navigate="/katas/48-redirects" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-teal-500"></span>
                   48 - Live Redirects
                 </.link>
                 <.link navigate="/katas/49-translator" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-500"></span>
                   49 - The Translator
                 </.link>
                 <.link navigate="/katas/50-components" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-500"></span>
                   50 - Functional Components
                 </.link>
                 <.link navigate="/katas/51-card" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-500"></span>
                   51 - The Card
                 </.link>
                 <.link navigate="/katas/52-button" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-500"></span>
                   52 - The Button
                 </.link>
                 <.link navigate="/katas/53-icon" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-500"></span>
                   53 - The Icon
                 </.link>
                 <.link navigate="/katas/54-modal" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-500"></span>
                   54 - The Modal
                 </.link>
                 <.link navigate="/katas/55-slideover" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-500"></span>
                   55 - The Slide-over
                 </.link>
                 <.link navigate="/katas/56-tooltip" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-500"></span>
                   56 - The Tooltip
                 </.link>
                 <.link navigate="/katas/57-dropdown" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-500"></span>
                   57 - The Dropdown
                 </.link>
                 <.link navigate="/katas/58-flash" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-teal-500"></span>
                   58 - Flash Messages
                 </.link>
                 <.link navigate="/katas/59-skeleton" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-500"></span>
                   59 - The Skeleton
                 </.link>
                 <.link navigate="/katas/60-progress" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-500"></span>
                   60 - The Progress Bar
                 </.link>
                 <.link navigate="/katas/61-stateful" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-blue-500"></span>
                   61 - Stateful Component
                 </.link>
                 <.link navigate="/katas/62-component-id" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-green-500"></span>
                   62 - Component ID
                 </.link>
                 <.link navigate="/katas/63-send-update" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-purple-500"></span>
                   63 - Send Update
                 </.link>
                 <.link navigate="/katas/64-send-self" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-pink-500"></span>
                   64 - Send Self
                 </.link>
                 <.link navigate="/katas/65-child-parent" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-indigo-500"></span>
                   65 - Child-to-Parent
                 </.link>
                 <.link navigate="/katas/66-sibling" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-cyan-500"></span>
                   66 - Sibling Communication
                 </.link>
                 <.link navigate="/katas/67-lazy" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-orange-500"></span>
                   67 - Lazy Loading
                 </.link>
                 <.link navigate="/katas/68-changesets" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-teal-500"></span>
                   68 - Changesets 101
                 </.link>
                 <.link navigate="/katas/69-crud" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-yellow-500"></span>
                   69 - The CRUD
                 </.link>
                 <.link navigate="/katas/70-optimistic" class="group flex items-center px-4 py-2 text-sm font-medium rounded-md text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 hover:text-gray-900 dark:hover:text-white">
                   <span class="w-2 h-2 mr-3 rounded-full bg-red-500"></span>
                   70 - Optimistic UI
                 </.link>
              </div>
            </div>
          </nav>
        </div>
        <div class="p-4 border-t border-gray-200 dark:border-gray-700">
             <div class="flex justify-center">
                <.theme_toggle />
             </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="flex-1 flex flex-col overflow-hidden relative">
        <header class="flex items-center justify-between h-16 px-6 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 md:hidden">
             <span class="text-lg font-bold">Elixir Katas</span>
             <!-- Simple mobile menu placeholder or just basic nav -->
        </header>

        <main class="flex-1 overflow-y-auto bg-gray-50 dark:bg-gray-900 p-4 sm:p-6 lg:p-8">
           <.flash_group flash={@flash} />
           <div class="mx-auto max-w-5xl">
             {@inner_content}
           </div>
        </main>
      </div>
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
