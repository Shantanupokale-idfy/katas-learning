# Kata 05: The Color Picker

## Goal
Manage **multiple related state values** (Red, Green, Blue) and apply them as **inline styles** to an element.

## Core Concepts

### 1. Multiple Assigns
You can assign multiple keys at once.
```elixir
assign(socket, r: 255, g: 0, b: 0)
```

### 2. Inline Styles
Interpolate state directly into the `style` attribute.
```elixir
<div style={"background-color: rgb(#{@r}, #{@g}, #{@b})"}>
```

### 3. Range Inputs
Use `<input type="range">` for numerical sliders.
```html
<input type="range" min="0" max="255" name="r" value={@r} />
```

## Implementation Details

1.  **State**: Initialize `r`, `g`, `b` to `0` (or a starting color).
2.  **UI**:
    - A colored box using inline styles.
    - Three range inputs (sliders).
3.  **Events**:
    - A single `handle_event("update_color", params, socket)` can handle all three inputs if they are in the same form.
    - Parse the string parameters ("255") to integers before assigning.

## Tips
- `String.to_integer/1` is your friend when dealing with form params, as they always come in as strings.
