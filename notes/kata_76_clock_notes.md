# Kata 76: Clock (Timers)

## Goal
Update the UI periodically using `Process.send_after` or `:timer.send_interval`.

## Core Concepts

### 1. `:timer.send_interval`
Sends a message to the process every X milliseconds.
Always check `connected?(socket)` before starting timers to avoid duplicate timers during the initial HTTP render + WS connection.

## Implementation Details

1.  **Mount**: Start timer.
2.  **handle_info(:tick)**: Update `current_time`.

## Tips
- Always ensure you don't leak timers. Linked processes (like the LiveView) automatically clean up linked timers, but manual loops might need care.

## Challenge
Add a **Format Toggle**. Switch between **24-hour** (`%H:%M:%S`) and **12-hour** (`%I:%M:%S %p`) formats using a button.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># State: format (string)
# Render: Calendar.strftime(@current_time, @format)
</code></pre>
</details>
