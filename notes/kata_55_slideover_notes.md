# Kata 55: Slideover (Drawer)

## Goal
Create a "Drawer" or "Slideover" that enters from the side of the screen, typically used for mobile menus or details panels.

## Core Concepts

### 1. Transitions
Animation is key for slide-overs. Without transition, it feels jarring.
(Note: LiveView has `JS.transition`, but simpler CSS transitions on mounting elements work too).

### 2. Fixed Positioning
The panel uses `fixed right-0 top-0 h-full` to anchor to the side.

## Implementation Details

1.  Similar to Modal (backdrop checking).
2.  Panel positioning is the main difference.

## Tips
- On mobile, slide-overs are often preferred over centered modals because they maximize vertical space.

## Challenge
Make the side **Configurable**. Add `attr :side, :string, default: "right"`. Allow the drawer to slide in from the **Left** if specified.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">class={
  if @side == "left", do: "left-0 ...", else: "right-0 ..."
}
</code></pre>
</details>
