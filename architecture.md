# Elixir Katas Architecture

This document outlines the architecture of the Elixir Katas application and provides a guide for adding new katas.

## Architecture Overview

The application is built with **Phoenix LiveView** 1.0+.

### Core Structure
- **Katas as LiveViews**: Each kata is a distinct LiveView module located in `lib/elixir_katas_web/live/`.
  - Naming Convention: `kata_XX_name_live.ex` (e.g., `kata_09_tabs_live.ex`).
  - Namespace: `ElixirKatasWeb.KataXXNameLive`.
- **Shared Layout**:
  - `layouts.ex` defines the main application shell, including the sidebar navigation.
  - `root.html.heex` provides the base HTML structure.
- **Components**:
  - `KataComponents.kata_viewer/1`: The standard wrapper for all katas. It handles the tabbed interface (Interactive, Source, Notes) and layout consistency.
- **Notes**: Markdown files in `notes/` provide the educational content for each kata.

---

## How to Add a New Kata

Adding a new kata involves touching 5 distinct files. Follow this checklist:

For each kata add the "Interactive", "Source Code" and "Notes" tabs.

### 1. Create the LiveView Module
**Path:** `lib/elixir_katas_web/live/kata_XX_name_live.ex`

Create a new file with the following structure. Replace `XX` and `Name` appropriately.

```elixir
defmodule ElixirKatasWeb.KataXXNameLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    # Load source code and notes for the viewer
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_XX_name_notes.md")

    {:ok, 
     socket
     |> assign(active_tab: "interactive") # Required for KataViewer
     |> assign(source_code: source_code)
     |> assign(notes_content: notes_content)
     # ... Initialize your kata-specific state here ...
     }
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata XX: [Name]" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <!-- YOUR KATA UI GOES HERE -->
      <div class="p-4">
        ...
      </div>
    </.kata_viewer>
    """
  end

  # Required for KataViewer tab switching
  def handle_event("set_tab", %{"tab" => tab}, socket) do
    # Handle viewer tabs
    if tab in ["interactive", "source", "notes"] do
       {:noreply, assign(socket, active_tab: tab)}
    else
       # Handle your internal kata tabs/events if any
       {:noreply, socket} 
    end
  end

  # ... Your specific event handlers ...
end
```

### 2. Create the Notes File
**Path:** `notes/kata_XX_name_notes.md`

Create a markdown file explaining the concept.

```markdown
# Kata XX: [Name]

## The Goal
...

## Key Concepts
- ...
- ...

## The Solution
...
```

### 3. Add the Route
**Path:** `lib/elixir_katas_web/router.ex`

Add a new line to the `live_session :default` block:

```elixir
live "/katas/XX-name", KataXXNameLive
```

### 4. Update the Index Page
**Path:** `lib/elixir_katas_web/live/katas_index_live.ex`

Add a new `<.link>` card to the grid in `render/1`. Follow the existing pattern.

```elixir
<.link navigate="/katas/XX-name" class="card ...">
  ...
</.link>
```

### 5. Update the Sidebar
**Path:** `lib/elixir_katas_web/components/layouts.ex`

Add a new navigation link to the standard app layout in the `app/1` function.

```elixir
<.link navigate="/katas/XX-name" class="...">
  ...
</.link>
```

---

## Verification Checklist
- [ ] Server compiles without errors (`mix phx.server`).
- [ ] Route `/katas/XX-name` is accessible.
- [ ] Navigation link appears in the Sidebar.
- [ ] Card appears on the Home/Index page.
- [ ] "Source Code" tab correctly shows the file content.
- [ ] "Notes" tab correctly renders the markdown.
