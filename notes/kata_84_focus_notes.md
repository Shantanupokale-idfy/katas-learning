# Kata 84: Accessible Focus

## Goal
Manage keyboard focus for accessibility, especially after dynamic updates (e.g., opening a modal, deleting an item).

## Core Concepts

### 1. `JS.focus`
`Phoenix.LiveView.JS.focus(to: "#id")`.
Use this to move focus programmatically.

### 2. `sr-only` Live Regions
Use `ria-live="polite"` elements to announce changes to screen readers.

## Implementation Details

1.  **Event**: When action finishes, call `JS.focus`.
2.  **Example**: Clicking "Edit" moves focus to the input field.

## Tips
- Never leave focus "lost" (reset to `body`) after a modal closes; return it to the trigger button.

## Challenge
Implement **Looping Focus**. Add a "Next" button that cycles focus through 3 distinct inputs `input-a`, `input-b`, `input-c` in order.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("next_focus", _, socket) do
  next_id = get_next(socket.assigns.current_focus) # Logic
  {:noreply, push_event(socket, "js-focus", %{id: next_id})}
end
</code></pre>
</details>
