# Kata 75: Bulk Actions

## Goal
Perform operations on multiple stream items at once (Multi-select).

## Core Concepts

### 1. Selection State
Streams do not track "selected" state. You need a separate `MapSet` assign (e.g., `@selected_ids`) to track which IDs are checked.

### 2. Optimistic UI
When clicking "Delete Selected", you iterate through the selected IDs and call `stream_delete` for each one immediately.

## Implementation Details

1.  **Render**: Checkbox checked state depends on `MapSet.member?(@selected_ids, id)`.
2.  **Event**: `toggle_select` adds/removes ID from MapSet.

## Tips
- Avoid updating the *entire* stream just to toggle a checkbox. Use the separate `assign` for selected_ids and let LiveView patch just the checkbox attributes efficiently.

## Challenge
Add **"Select Only Even IDs"**. A button that programmatically selects item 2, 4, 6, etc.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("select_even", _, socket) do
  evens = Enum.filter(all_ids, &(rem(&1, 2) == 0)) |> MapSet.new()
  {:noreply, assign(socket, selected_ids: evens)}
end
</code></pre>
</details>
