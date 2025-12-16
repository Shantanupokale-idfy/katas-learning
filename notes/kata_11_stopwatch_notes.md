# Kata 11: The Stopwatch

## The Goal
Build a working stopwatch that can be started, stopped, and reset. The display should update automatically while running, showing minutes, seconds, and tenths of a second.

## Key Concepts
- **Server-driven Interval**: Using `Process.send_after/3` to create a loop that sends messages to `self()`.
- **Handling Info**: Using `handle_info/2` to react to internal process messages (like the tick) rather than user events (`handle_event/3`).
- **Formatting**: Converting raw state (e.g., total ticks) into a human-readable string (MM:SS.d).

## The Solution
We use a boolean flag `@running` to control the loop.

```elixir
# Start the loop
def handle_event("start", _, socket) do
  Process.send_after(self(), :tick, 100) # 100ms
  {:noreply, assign(socket, running: true)}
end

# The Loop
def handle_info(:tick, socket) do
  if socket.assigns.running do
    Process.send_after(self(), :tick, 100) # Schedule next
    {:noreply, update(socket, :time, &(&1 + 1))}
  else
    {:noreply, socket} # Stop scheduling if not running
  end
end
```

By keeping the state on the server, we can ensure the timing logic is consistent, although for critical timing applications, one might compare against `DateTime.utc_now()` to account for any drift in message passing latency. For a simple stopwatch kata, this tick-based approach is sufficient and easier to reason about.
