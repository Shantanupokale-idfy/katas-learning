# Kata 25: The Tree

## Goal
Render **recursive hierarchical data** (like a file tree) using functional components.

## Core Concepts

### 1. Recursive Components
A function component can call itself.
```elixir
def tree_node(assigns) do
  ~H"""
  <li>
    ...
    <.tree_node :for={child <- @node.children} node={child} />
  </li>
  """
end
```

### 2. State for Expansion
Track which nodes are expanded using a `MapSet` of IDs (`expanded_ids`).
- Do not mutate the tree data structure itself (e.g., adding `expanded: true` to every node map). Keeping UI state separate from data is cleaner.

## Implementation Details

1.  **State**: `tree` (nested maps), `expanded_ids` (MapSet).
2.  **UI**:
    - A specific functional component `tree_node` defined in the same module.
    - Recursion happens inside the `if expanded?` block.
3.  **Events**:
    - `toggle`: Adds/removes an ID from the MapSet.

## Tips
- Ensure your data has unique IDs.
- Indentation is usually handled via CSS (margin-left or padding-left) inside the recursive child `<ul>`.
