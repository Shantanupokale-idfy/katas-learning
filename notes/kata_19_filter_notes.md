# Kata 19: The Filter

## The Goal
Implement real-time list filtering based on user input.

## Key Concepts
- **Derived State**: We store the `query` in the state, but we don't necessarily need to store `filtered_items`. We can compute the filtered list on the fly during render (`filtered_items(@items, @query)`). This ensures the list is always in sync with the source data and query.
- **Case Insensitive Matching**: Using `String.downcase/1` on both the item text and the query to ensure "elixir" matches "Elixir".

## The Solution

```elixir
def handle_event("filter", %{"query" => query}, socket) do
  {:noreply, assign(socket, query: query)}
end

# In Render or Helper
Enum.filter(items, fn item -> 
  String.contains?(String.downcase(item), String.downcase(query)) 
end)
```
