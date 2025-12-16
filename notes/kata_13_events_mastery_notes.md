# Kata 13: Events Mastery

## The Goal
Understand different types of events that can be bound to DOM elements, specifically Focus, Blur, and KeyUp.

## Key Concepts
- **Focus/Blur**: `phx-focus` triggers when an element gains focus, and `phx-blur` when it loses it. Useful for validation or UI hints.
- **Key Events**: `phx-keyup` triggers whenever a key is released while the element has focus. It sends the `key` pressed in the payload.
- **Payload Extraction**: Accessing `%{"key" => key}` or `%{"value" => value}` in the handle_event callback.

## The Solution
We attach multiple bindings to the same input:

```html
<input 
  phx-focus="focus_event"
  phx-blur="blur_event"
  phx-keyup="keyup_event"
/>
```

And handle them separately:

```elixir
def handle_event("keyup_event", %{"key" => key}, socket) do
  # Log the specific key pressed
end
```
