# Kata 08: The Accordion

## Goal
The goal of this kata is to manage state for a **collection of items**, where only one item can be active at a time.

## Core Concepts

### 1. Active ID Pattern
Instead of storing a boolean for every item, store a single `active_id` in the socket assigns.
```elixir
socket |> assign(active_id: "item-1")
```

### 2. Comparison Logic
In the template, check if the current item's ID matches the active ID to determine visibility.
```elixir
:if={@active_id == item.id}
```

## Steps to Create

1.  **Define state**: Initialize `active_id` to `nil` (all closed).
2.  **Render UI**:
    *   A list of questions/answers.
    *   Clicking a question toggles its answer.
    *   Opening one closes others.
3.  **Handle interaction**: 
    *   If clicking the already open item -> set `active_id` to `nil`.
    *   Otherwise -> set `active_id` to the clicked item's ID.

## Tips
- This pattern scales better than maintaining a list of booleans.
- Use `phx-value-id` to pass arguments to your event handler.
