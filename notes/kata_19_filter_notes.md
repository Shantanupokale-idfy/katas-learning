# Kata 19: The Filter

## Goal
Implement **real-time filtering** (search). As the user types, the list should instantly shrink to show only matching results.

## Core Concepts

### 1. Source of Truth
Keep the *full* list of items in the state (`items`). Do not delete items from the state when filtering; just hide them.

### 2. Derived Rendering
Perform the filtering at render time (or in a computed assign).
```elixir
filtered_items = Enum.filter(@items, fn i -> ... end)
```
This ensures that if the user clears the search, all items reappear.

### 3. Filtering Logic
Use `String.contains?/2` and `String.downcase/1` for case-insensitive partial matching.

## Implementation Details

1.  **State**: `items` (full list), `query` (search string).
2.  **UI**:
    - Search input bound with `phx-change`.
    - Loop over the *result* of the filter function, not the raw `@items`.
3.  **Events**:
    - `handle_event("search", %{"query" => q}, socket)`: Update the query state.

## Tips
- For large lists, filtering on every keystroke might be slow. Use `phx-debounce="300"` on the input.

## Challenge
Add a **Clear** button (x) inside the search input that clears the query and resets the list.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">&lt;button phx-click="clear" class="absolute right-2 top-2"&gt;x&lt;/button&gt;

def handle_event("clear", _, socket) do
  {:noreply, assign(socket, query: "")}
end</code></pre>
</details>
