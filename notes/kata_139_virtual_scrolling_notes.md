# Kata 139: Virtual Scrolling

## Goal
Render huge lists (10k+ items) efficiently by only rendering the visible viewport.

## Core Concepts

### 1. Windowing
Calculate `visible_start` and `visible_end` based on `scrollTop`.
`visible_items = Enum.slice(all_items, start, len)`.

### 2. Padding/Overscan
Render a few items above and below the viewport to prevent white flickers during fast scrolling.

### 3. Spacer Divs
Use a top spacer (`padding-top` or absolute position) to push the visible items to the correct scroll position so the scrollbar remains accurate.

## Implementation Details

1.  **Hook**: `VirtualScroll`. Listens to scroll event, throttles it, sends `scrollTop` to server.
2.  **Server**: Recalculates `visible_items`.

## Tips
- The challenge is keeping the scrollbar smooth. If the server is slow, you might see blank space.

## Challenge
**Jump to Index**.
Add an input "Jump to Row #".
Updating it calculates the new `scrollTop` (`index * item_height`) and pushes a `scrollTo` event to the Hook to update the DOM position.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("jump", %{"row" => r}, socket) do
  top = String.to_integer(r) * @item_height
  push_event(socket, "scroll_to", %{top: top})
end
</code></pre>
</details>
