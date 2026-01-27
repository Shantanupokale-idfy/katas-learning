# Kata 72: Infinite Scroll

## Goal
Load data incrementally as the user scrolls down, creating an "infinite" feed experience.

## Core Concepts

### 1. Intersection Observer
A JavaScript API (via a Hook) that detects when a specific element (the "sentinel") enters the viewport.

### 2. Flow
1. User scrolls to bottom.
2. Hook detects visibility of sentinel.
3. Hook sends `load-more` event to server.
4. Server appends new items to stream.

## Implementation Details

1.  **Hook**: `InfiniteScroll` (defined in `assets/js/app.js` or similar).
2.  **Event**: `handle_event("load-more", ...)` appends data using `stream_insert`.

## Tips
- Ensure you have a "Stop" condition (`has_more: false`) to prevent infinite requests when data runs out.

## Challenge
Add a **Reset** button that clears the stream, sets the page back to 1, and scrolls the container to the top.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("reset", _, socket) do
  {:noreply, 
   socket 
   |> assign(page: 1, has_more: true) 
   |> stream(:items, initial_items, reset: true)} # reset: true clears DOM
end
</code></pre>
</details>
