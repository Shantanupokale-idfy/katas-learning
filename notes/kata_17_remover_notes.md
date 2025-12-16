# Kata 17: The Remover

## The Goal
Render a list of structured data (maps with IDs) and implement functionality to remove specific items.

## Key Concepts
- **Unique IDs**: When managing lists of data using map/structs, it is crucial to have a unique ID (`uuid`) to reliably identify which item to act upon.
- **Phx-value-***: Passing data payload with events.
- **Reject/Filter**: Using `Enum.reject/2` to create a new list excluding the target item.

## The Solution
We pass the item's ID in the click event payload:

```html
<button phx-click="remove" phx-value-id={item.id}>X</button>
```

And handle it by filtering the list:

```elixir
def handle_event("remove", %{"id" => id}, socket) do
  # Remove item where ID matches
  new_items = Enum.reject(socket.assigns.items, fn i -> i.id == id end)
  {:noreply, assign(socket, items: new_items)}
end
```
