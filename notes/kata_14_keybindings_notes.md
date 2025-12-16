# Kata 14: Keybindings

## The Goal
Capture keyboard events globally (on the window object) to implement page-wide shortcuts, regardless of which element is focused.

## Key Concepts
- **Window Events**: Binding `phx-window-keydown` to a container (often the top-level div) allows intercepting keys even if no specific input is focused.
- **Pattern Matching Keys**: Handling specific keys (like "j", "k", "Escape", "Enter") in the event handler.

## The Solution

```elixir
<div phx-window-keydown="keydown_event">...</div>

def handle_event("keydown_event", %{"key" => "k"}, socket) do
  # Increment logic
end
```

This pattern is essential for power-user features like "press '/' to search" or "press 'Esc' to close modal".
