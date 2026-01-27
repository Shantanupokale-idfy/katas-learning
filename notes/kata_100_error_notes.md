# Kata 100: Error Boundaries

## Goal
Handle crashes gracefully. If a LiveComponent or LiveView crashes, the Supervisor should restart it, and the client should reconnect.

## Core Concepts

### 1. "Let it Crash"
Elixir's philosophy. Don't code defensively against impossible states. If it happens, crash and reset to a known good state.

### 2. Client Reconnect
Phoenix JS client automatically attempts to rejoin the channel.

## Implementation Details

1.  **Demo**: Requires a button that explicitly `raise "Error"`.

## Tips
- LiveComponents run in the *same* process as the Parent LiveView. A crash in a component crashes the *whole view*.

## Challenge
**The Crash Button**.
Add a button "Simulate Crash".
Clicking it raises an exception. Observe how the UI momentarily blinks/freezes and then reloads (resets to initial state).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("crash", _, _) do
  raise "Simulated Crash!"
end
</code></pre>
</details>
