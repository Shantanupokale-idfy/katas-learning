# Kata 81: Live Cursors

## Goal
Track and display mouse cursors from other users in real-time.

## Core Concepts

### 1. Hook Throttling
Sending every `mousemove` event to the server will kill performance. The Hook **must** throttle/debounce the valid events (e.g., every 50ms).

### 2. Coordinate System
Map screen coordinates to percentage (0-100%) or absolute pixels if the container is fixed size.

## Implementation Details

1.  **Hook**: `CursorTracker` (sends `cursor-move`).
2.  **Broadcast**: PubSub sends `{:cursor_update, ...}`.

## Tips
- Use `pointer-events-none` on the cursor elements so they don't block clicks on the underlying UI.

## Challenge
Broadcast **Clicks**. When a user clicks, show a "Ping" or Ripple animation at that location.
Add a `phx-click` or Hook listener for mousedown, broadcast `{:click, x, y}`.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># On click event:
Phoenix.PubSub.broadcast(..., {:click, x, y})
# On handle_info:
assign(socket, clicks: [new_click | clicks])
# Render a temporary div that animates and disappears (use JS.hide/remove after X ms)
</code></pre>
</details>
