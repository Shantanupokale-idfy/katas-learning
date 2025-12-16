# Kata 18: The Editor

## The Goal
Implement inline editing functionality where a list item turns into an input field when clicked and saves changes on submit.

## Key Concepts
- **Conditional Rendering per Item**: Checking `item.id == @editing_id` inside the loop to determine whether to render text or an input.
- **Autofocus**: Automatically focusing the input when it appears so the user can type immediately.
- **Optimistic UI**: Swapping state instantly to "edit mode" feels responsive.

## The Solution
We store an `editing_id`.

```elixir
<%= if @editing_id == item.id do %>
  <!-- Render Form -->
<% else %>
  <!-- Render Text with phx-click="edit" -->
<% end %>
```

On save, we map over the list to update specific item:

```elixir
Enum.map(items, fn item -> 
  if item.id == target_id, do: %{item | text: new_text}, else: item
end)
```
