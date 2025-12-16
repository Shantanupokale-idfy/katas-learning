# Kata 12: The Timer

## The Goal
Create a countdown timer that starts from a fixed time (e.g., 60 seconds) and counts down to zero.

## Key Concepts
- **Countdown Logic**: Decrementing state on a server interval.
- **Conditional Termination**: Stopping the interval when the state reaches a termination condition (zero).
- **DaisyUI Countdown**: Using the daisyUI `countdown` component which uses CSS variables for animation (optional, but used here).

## The Solution
We use the same `Process.send_after` pattern as the Stopwatch, but we decrement instead of increment.

```elixir
def handle_info(:tick, socket) do
  if socket.assigns.running and socket.assigns.seconds > 0 do
    Process.send_after(self(), :tick, 1000)
    {:noreply, update(socket, :seconds, &(&1 - 1))}
  else
    {:noreply, assign(socket, running: false)} # Auto-stop at 0
  end
end
```
