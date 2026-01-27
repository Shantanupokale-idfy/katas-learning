# Kata 59: Skeleton Loading

## Goal
Display a **Skeleton Screen** (placeholder shapes) while data is loading. This reduces perceived latency compared to a blank screen or a spinner.

## Core Concepts

### 1. Pulse Animation
Taiwind's `animate-pulse` class creates a subtle fading effect that indicates activity.

### 2. Layout Matching
The skeleton should roughly match the layout of the final content (header bar, image block, text lines) to minimize layout shift.

## Implementation Details

1.  **State**: `loading` (Boolean).
2.  **Render**: `if @loading, do: <Skeleton>, else: <Content>`.

## Tips
- Use gray backgrounds (`bg-gray-200`) with rounded corners to simulate text and image blocks.

## Challenge
Add a **Fade In** transition. When `@loading` switches to `false`, the content should fade in opacity (e.g., `opacity-0` -> `opacity-100` transition). You can use a CSS class or `JS.transition`.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"><div class={if !@loading, do: "animate-fade-in", else: ""}>
  ...
</div>
# Or simple CSS transition utility
<div class={"transition-opacity duration-500 " <> if(@loading, do: "opacity-0", else: "opacity-100")}>
</code></pre>
</details>
