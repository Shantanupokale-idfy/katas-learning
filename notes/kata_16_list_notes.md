# Kata 16: The List

## The Goal
Render a list of items and start understanding list manipulation in a functional way (appending items).

## Key Concepts
- **List Comprehensions**: Using `<%= for item <- @items do %>` to iterate and render content.
- **Immutability**: Appending to a list (`items ++ [new_item]`) creates a new list rather than mutating the old one.

## The Solution
We maintain a list of strings in the assigns.
When the form submits:
```elixir
def handle_event("add", %{"text" => text}, socket) do
  # Append to end of list
  new_items = socket.assigns.items ++ [text]
  {:noreply, assign(socket, items: new_items)}
end
```

Note: In Elixir, appending to a list is O(n). For very large lists, prepending `[text | items]` is O(1) and generally preferred, but for UI lists where order matters (top to bottom), appending is often more intuitive for beginners unless we reverse the list at render time.
