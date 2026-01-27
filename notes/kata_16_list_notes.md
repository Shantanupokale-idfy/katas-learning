# Kata 16: The List

## Goal
Render a dynamic list of items and implement "Add" functionality. This introduces **Collections** (Lists) in LiveView.

## Core Concepts

### 1. Rendering Lists
Use list comprehensions (`for`) inside your template to render HTML for each item.

```elixir
<%= for item <- @items do %>
  <li>{item}</li>
<% end %>
```

### 2. Immutability
To add an item, you create a *new* list containing the old items plus the new one. Use `[new | old]` (prepend) or `old ++ [new]` (append).

```elixir
# Prepend is O(1) - faster
new_list = [item | @items]
```

## Implementation Details

1.  **State**: `items` (list of strings), `new_item` (for the input).
2.  **UI**:
    - A form with a text input.
    - A `<ul>` rendering the items.
3.  **Events**:
    - `handle_event("add", params, socket)`: Extracts the value, appends it to the list, and clears the input.

## Tips
- For large lists, specialized features like `streams` (covered in advanced katas) are preferred over raw lists to optimize memory and DOM patching. For small lists, raw assigns are perfect.

## Challenge
Add a **Prepend** button that adds the new item to the **top** of the list instead of the bottom.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("prepend", %{"text" => text}, socket) do
  # [new | old] is O(1)
  {:noreply, update(socket, :items, fn items -> [text | items] end)}
end</code></pre>
</details>
