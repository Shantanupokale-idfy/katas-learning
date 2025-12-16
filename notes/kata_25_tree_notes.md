# Kata 25: The Tree

## Overview
Displaying hierarchical data (folders, organizational charts, category trees) requires recursive rendering. In LiveView, we can achieve this elegantly using functional components that call themselves.

## Key Concepts
1.  **Recursive Components**:
    - A functional component can render itself.
    - **Termination Condition**: The recursion stops when there are no children, or (visually) when a parent is collapsed.

    ```heex
    def tree_node(assigns) do
      ~H"""
      <li>
        ...Self content...
        <%= if expanded? do %>
          <%= for child <- @node.children do %>
            <.tree_node node={child} ... />
          <% end %>
        <% end %>
      </li>
      """
    end
    ```

2.  **State**:
    - `expanded_ids`: A `MapSet` used to track which nodes are open. This is better than mutating the tree structure itself to add an `expanded: true` field.

3.  **Visuals**:
    - Icons (Folder vs File) aid understanding.
    - Indentation (padding/margin) visualizes depth.

## Extensions
- Drag and drop nodes (reordering).
- Select a node (active highlight).
- "Expand All" / "Collapse All".
