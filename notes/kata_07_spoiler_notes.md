# Kata 07: The Spoiler

## Goal
The goal of this kata is to create a component that **hides content** until specifically requested by the user.

## Core Concepts

### 1. Conditional CSS
Instead of removing content from the DOM (like `:if`), "Spoilers" often keep content but obscure it.
```elixir
class={if @visible, do: "", else: "blur-md select-none"}
```

### 2. State Toggle
A simple boolean toggle controls the visibility.
```elixir
def handle_event("toggle_visibility", _, socket) do
  {:noreply, update(socket, :visible, &(!&1))}
end
```

## Steps to Create

1.  **Define state**: Initialize `visible` to `false`.
2.  **Render UI**:
    *   A card with "Sensitive Information".
    *   An overlay button "Click to Reveal".
    *   The overlay should disappear when clicked, revealing the content.
3.  **Handle interaction**: Toggle the state on click.

## Tips
- Use `backdrop-filter: blur(8px)` for a modern glass effect.
- Ensure the hidden text cannot be selected/copied easily (`user-select: none`).
