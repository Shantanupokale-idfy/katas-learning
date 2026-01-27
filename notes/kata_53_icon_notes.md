# Kata 53: Icon System

## Goal
Encapsulate SVG icons into a component to avoid repeating verbose SVG code throughout your templates.

## Core Concepts

### 1. Icon Library
Store the SVG paths in function pattern matching (as seen in `Function Component` approach) or load from a sprite sheet.

### 2. Passing Class
Allow consumers to pass `class` to size or color the icon.
```elixir
<.icon name="home" class="w-8 h-8 text-red-500" />
```

## Implementation Details

1.  **Attr**: `:name` (required), `:class` (optional).
2.  **Render**: Choose the SVG path based on `@name`.

## Tips
- Use `Heroicons` or `Lucide` as content sources.

## Challenge
Add a **Rotation** prop. `attr :rotate, :integer, default: 0`. Apply a transform style or class to rotate the icon by that many degrees (e.g. 90, 180).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">style={"transform: rotate(#{@rotate}deg);"}
# or Tailwind: class={"rotate-#{@rotate}"}
</code></pre>
</details>
