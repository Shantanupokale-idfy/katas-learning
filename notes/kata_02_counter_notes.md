# Kata 02: The Counter

## Goal
Build a counter with increment, decrement, and reset functionality. This teaches basic **State Management** and arithmetic operations on state.

## Core Concepts

### 1. Updating State
State in LiveView is immutable. We use `update/3` to efficiently modify a value based on its previous state.

```elixir
# Increment count by 1
update(socket, :count, &(&1 + 1))
```

### 2. Multiple Events
You can define multiple `phx-click` bindings, each pointing to a different event name (`inc`, `dec`, `reset`).

### 3. Binding to UI
Display the state using `{@count}`. LiveView automatically tracks this dependency and only updates this part of the DOM when `count` changes.

## Implementation Details

1.  **State**: Initialize `count` to `0` in `mount/3`.
2.  **UI**:
    - Display the current count prominently.
    - Add buttons for `+`, `-`, and `Reset`.
3.  **Events**:
    - `handle_event("inc", ...)`: Adds 1 to count.
    - `handle_event("dec", ...)`: Subtracts 1 from count.
    - `handle_event("reset", ...)`: Sets count to 0.

## Tips
- Pattern match on the event name in `handle_event/3` to keep your code clean.
- Use `phx-window-keydown` (covered in later katas) if you wanted keyboard support.
