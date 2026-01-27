# Kata 56: Tooltip

## Goal
Create a Tooltip component that reveals extra information when hovering over an element.

## Core Concepts

### 1. Group Hover (Tailwind)
Use the `group` class on the parent and `group-hover:visible` (or `group-hover:opacity-100`) on the child. This allows purely CSS-based toggling without server roundtrips.

### 2. Positioning
Absolute positioning relative to the parent (`relative inline-block`) places the tooltip precisely.

## Implementation Details

1.  **Structure**:
    ```html
    <div class="relative group">
      <button>Target</button>
      <div class="absolute ... invisible group-hover:visible">Tooltip</div>
    </div>
    ```

## Tips
- Ensure the tooltip has a higher `z-index` if it overlaps other content.
- `whitespace-nowrap` prevents the tooltip text from wrapping awkwardly.

## Challenge
Add configurable **Positioning**. Add `attr :position, :string, default: "top"`. Support "top" vs "bottom" by changing the CSS classes (e.g., `bottom-full` vs `top-full`).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">class={
  case @position do
    "top" -> "bottom-full mb-2"
    "bottom" -> "top-full mt-2"
  end
}
</code></pre>
</details>
