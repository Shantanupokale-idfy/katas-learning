# Kata 17: The Remover

## Goal
Implement a "Delete" function for items in a list. This requires uniquely identifying items.

## Core Concepts

### 1. Unique IDs
When working with data that can be reordered or removed, using stable distinct IDs (like UUIDs) is crucial. Do not rely on index.

### 2. Passing Values with Events
Use `phx-value-*` attributes to attach data to an event.

```html
<button phx-click="delete" phx-value-id={item.id}>Delete</button>
```

### 3. Rejecting Items
Use `Enum.reject/2` to filter the list.

```elixir
Enum.reject(items, fn i -> i.id == target_id end)
```

## Implementation Details

1.  **State**: `items` (list of maps `%{id: ..., text: ...}`).
2.  **UI**: Render list items with a "Delete" button next to each.
3.  **Events**:
    - `handle_event("delete", %{"id" => id}, socket)`: Remove the matching item from the list.

## Tips
- Using `phx-value-id` always sends the value as a **String**. If your IDs are integers in Elixir, remember to cast them or compare them as strings.
