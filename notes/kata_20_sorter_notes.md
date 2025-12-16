# Kata 20: The Sorter

## The Goal
Implement a table where clicking on column headers sorts the data by that field, toggling between ascending and descending order.

## Key Concepts
- **Sort State**: Tracking both the `sort_by` field and the `sort_order` (:asc or :desc).
- **Toggle Logic**: If clicking the *same* field, flip the order. If clicking a *different* field, reset to default order (asc).
- **Dynamic Sorting**: Using `Enum.sort_by/3` with dynamic field access (`Map.get(item, field)`).

## The Solution
We use helper functions to keep the template and the logic clean.

Logic:
```elixir
new_order = 
  if @sort_by == field and @sort_order == :asc do
    :desc
  else
    :asc
  end
```

Representation:
```elixir
defp sort_indicator(current_field, order, target_field) do
  if current_field == target_field do
    if order == :asc, do: "▲", else: "▼"
  end
end
```
