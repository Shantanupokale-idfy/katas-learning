# Kata 57: Dropdown Menu

## Goal
Build a toggleable Dropdown menu for actions or navigation.

## Core Concepts

### 1. Toggle State
A simple boolean (`show_dropdown`) determines whether the menu `<div>` is rendered.

### 2. Click Away (Out)
A common requirement is closing the menu when the user clicks *outside* of it.
LiveView provides `phx-click-away`.

## Implementation Details

1.  **State**: `show_dropdown` (Boolean).
2.  **Events**:
    *   `toggle`: Flip state.
    *   `close`: Set false.

## Tips
- Use `phx-click-away="close_dropdown"` on the dropdown container to handle the "click outside" behavior cleanly.

## Challenge
Implement **Click Away**. Add the `phx-click-away` binding to the dropdown container so that it closes if the user clicks anywhere else on the page.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"><div class="absolute ..." phx-click-away="close_dropdown">...</div>

def handle_event("close_dropdown", _, socket) do
  {:noreply, assign(socket, show_dropdown: false)}
end
</code></pre>
</details>
