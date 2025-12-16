# Kata 02: The Counter

## Goal
The goal of this kata is to understand **State Management** in LiveView. You will build a counter with increment, decrement, and reset functionality.

## Core Concepts

### 1. `socket.assigns`
The state of your LiveView is stored in `socket.assigns`. It is an immutable map. To change the state, you must return a new socket with updated assigns.

### 2. Events (`phx-click`)
We use `phx-click="event_name"` to send an event to the server when an element is clicked.

```html
<button phx-click="inc">+</button>
```

### 3. `handle_event/3`
This callback handles events sent from the browser. It receives the event name, parameters, and the socket. It must return `{:noreply, new_socket}`.

```elixir
def handle_event("inc", _params, socket) do
  # update/3 is useful for modifying existing values
  {:noreply, update(socket, :count, &(&1 + 1))}
end

def handle_event("reset", _params, socket) do
  # assign/2 is useful for setting specific values
  {:noreply, assign(socket, count: 0)}
end
```

## Steps to Create

1.  **Define state**: Initialize `count` to 0 in `mount/3`.
2.  **Render UI**: Show the count and buttons in `render/1`.
3.  **Handle interaction**: Implement `handle_event/3` for `inc`, `dec`, and `reset`.

## Tips
- **Interpolation**: Use `{@count}` in your template to display the value.
- **Pattern Matching**: You can pattern match on the event name in multiple `handle_event` clauses.
