# Kata 58: Flash Messages

## Goal
Display temporary feedback messages (Success, Error) to the user.

## Core Concepts

### 1. `put_flash/3`
Standard Phoenix function to store messages in the connection/socket. LiveView handles rendering them (usually in a layout, but here locally).

### 2. Dismissal
Allow the user to manually close the message.

## Implementation Details

1.  **State**: `show_flash` (boolean) or check `flash` assigns directly if using standard flash.
2.  **UI**: A noticeable banner with a close button.

## Tips
- For better UX, messages should often disappear automatically after a few seconds.

## Challenge
Implement **Auto-Dismiss**. When the flash is shown, schedule a message to self (`Process.send_after`) to clear it after 3 seconds.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("show_message", _, socket) do
  Process.send_after(self(), :clear_flash, 3000)
  {:noreply, assign(socket, show_flash: true)}
end

def handle_info(:clear_flash, socket) do
  {:noreply, assign(socket, show_flash: false)}
end
</code></pre>
</details>
