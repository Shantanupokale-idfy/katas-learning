# Kata 23: The Multi-Select

## Overview
Selecting multiple items is a common UI pattern. Unlike a standard `<select multiple>`, modern UIs often use pills, tags, or checkboxes. This kata demonstrates managing a set of selected items using `MapSet`.

## Key Concepts
1.  **State**:
    - `items`: The list of available options.
    - `selected`: A `MapSet` of selected item IDs or values. Using `MapSet` ensures uniqueness and provides O(1) lookups.

2.  **Toggling Logic**:
    - If the item is in the set, remove it.
    - If not, add it.
    
    ```elixir
    # Inside handle_event
    if MapSet.member?(set, item) do
      MapSet.delete(set, item)
    else
      MapSet.put(set, item)
    end
    ```

3.  **Visual Feedback**:
    - Conditional classes based on membership: `if MapSet.member?(@selected, item), do: "active", else: "inactive"`.

## Extensions
- Add a "Select All" button.
- Limit the maximum number of selections (e.g., "Pick up to 3").
- Filter the available items (combining with Kata 19).
