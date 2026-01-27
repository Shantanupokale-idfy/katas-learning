# Kata 60: Progress Bar

## Goal
Visualize the status of a long-running background task.

## Core Concepts

### 1. Component State Loop
The component sends messages to itself (`Process.send_after`) to simulate progress over time.

### 2. Visual Width
Map the integer percentage (0-100) to a CSS width style (`style="width: #{@progress}%"`).

## Implementation Details

1.  **State**: `progress` (Integer).
2.  **Events**:
    *   `start`: Kick off the loop.
    *   `handle_info`: Increment progress, re-schedule if < 100.

## Tips
- Use a transition (`transition-all duration-300`) on the width property to make the movement smooth instead of jumpy.

## Challenge
Add a **Pause/Resume** button. You'll need to track a `status` (`:idle`, `:running`, `:paused`). If paused, `handle_info` should not schedule the next tick.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("pause", _, socket) do
  {:noreply, assign(socket, status: :paused)}
end

# In handle_info:
if socket.assigns.status == :running do
   Process.send_after(...)
end
</code></pre>
</details>
