# Kata 06: The Resizer

## Goal
The goal of this kata is to use state values to control the **dimensions** of an element dynamically.

## Core Concepts

### 1. Binding Dimensions
You can bind integer state values to CSS properties like `width` and `height`.
```elixir
<div style={"width: #{@width}px; height: #{@height}px;"}></div>
```

### 2. Number Inputs
Use `type="number"` for precise integer control.
```html
<input type="number" name="width" value={@width} min="50" max="500" />
```

## Steps to Create

1.  **Define state**: Initialize `width` (e.g., 200) and `height` (e.g., 200).
2.  **Render UI**:
    *   Two inputs for Width and Height.
    *   A resizable container (e.g., a colored box).
    *   Display the current dimensions text.
3.  **Handle interaction**: Update state on form change.

## Tips
- Always sanitize or limit inputs to avoid breaking the layout (e.g., sets min/max).
- Adding `transition-all` via CSS makes the resizing smooth!
