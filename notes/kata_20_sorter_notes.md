# Kata 20: The Sorter

## Goal
Implement a data table with **sortable columns**. Clicking a header sorts by that field; clicking again reverses the order.

## Core Concepts

### 1. Sort State
You need to track two things:
- `sort_by`: The field currently being sorted (e.g., `:name`, `:age`).
- `sort_order`: The direction (`:asc` or `:desc`).

### 2. Dynamic Sorting
Use `Enum.sort_by/3`.
```elixir
Enum.sort_by(items, &Map.get(&1, @sort_by), @sort_order)
```

### 3. Toggle Logic
- If the user clicks the *same* column -> Flip the order.
- If the user clicks a *different* column -> Set new column, reset order to `:asc`.

## Implementation Details

1.  **State**: `items`, `sort_by`, `sort_order`.
2.  **UI**:
    - Table headers with `phx-click="sort"`.
    - Visual indicator (arrow) next to the active column.
3.  **Events**:
    - `sort`: Apply the toggle logic and update state.

## Tips
- Sorting is usually fast enough to do on the server for page-sized datasets. For database-backed lists, you would pass these params to your Ecto query.

## Challenge
Add a **Reset Sort** button that restores the list to its original unsorted order (e.g., set `sort_by` to `nil` or default ID).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("reset", _, socket) do
  {:noreply, assign(socket, sort_by: :id, sort_order: :asc)}
end</code></pre>
</details>
