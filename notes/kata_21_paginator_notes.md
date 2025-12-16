# Kata 21: The Paginator

## Overview
Pagination is essential for dealing with large datasets. Sending all data to the client at once is inefficient. This kata demonstrates **offset-based pagination**, where we calculate a "slice" of data to show based on the current page number and a fixed number of items per page.

## Key Concepts
1.  **State**: We need to track:
    - `page`: The current page number (starts at 1).
    - `per_page`: How many items to show per page.
    - `items`: The full dataset (in a real app, this might be a database query, but here it's a list).

2.  **Calculations**:
    - **Total Pages**: `ceil(total_items / per_page)`
    - **Current Slice**: We use `Enum.slice(items, offset, limit)` where `offset = (page - 1) * per_page`.

3.  **Events**:
    - `prev`: Decrements the page (min 1).
    - `next`: Increments the page (max total_pages).

## Implementation Details

```elixir
# Calculating the slice
defp paginated_items(items, page, per_page) do
  start_index = (page - 1) * per_page
  Enum.slice(items, start_index, per_page)
end

# Navigating
def handle_event("next", _, socket) do
  new_page = min(socket.assigns.page + 1, total_pages(...))
  {:noreply, assign(socket, :page, new_page)}
end
```

## Extensions
- Add a "Jump to Page" input.
- Make `per_page` configurable by the user.
- Add "First" and "Last" buttons.
