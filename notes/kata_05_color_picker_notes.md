# Kata 05: The Color Picker

## Goal
The goal of this kata is to learn how to manage **multiple related state values** and apply **inline styles** dynamically.

## Core Concepts

### 1. Multiple Assigns
You can assign multiple values to the socket at once.
```elixir
socket |> assign(r: 0, g: 0, b: 0)
```

### 2. Range Inputs
Input type `range` is perfect for numerical values within a bound.
```html
<input type="range" min="0" max="255" name="red" value={@r} />
```

### 3. Inline Styles
You can bind strings to the `style` attribute just like classes.
```elixir
<div style={"background-color: rgb(#{@r}, #{@g}, #{@b})"}></div>
```

## Steps to Create

1.  **Define state**: Initialize `r`, `g`, `b` to `0` in `mount/3`.
2.  **Render UI**:
    *   Three sliders (Red, Green, Blue).
    *   A preview box that changes color.
    *   Display the current RGB string.
3.  **Handle interaction**: Implement `handle_event` to update the specific color channel.
