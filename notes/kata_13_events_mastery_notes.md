# Kata 13: Events Mastery

## Goal
Understand different DOM events: **Focus**, **Blur**, and **KeyUp**. These are essential for rich form interactions, validation, and keyboard shortcuts within inputs.

## Core Concepts

### 1. Focus & Blur
- `phx-focus`: Triggered when an element gains focus (user clicks in or tabs to it).
- `phx-blur`: Triggered when an element loses focus (user tabs away or clicks elsewhere).
Great for showing helper text or validating a field *after* the user is done typing.

### 2. KeyUp
- `phx-keyup`: Triggered when a keyboard key is released.
- The payload contains the specific key: `%{"key" => "Enter"}`.

## Implementation Details

1.  **UI**: A single input field with multiple bindings.
    ```html
    <input phx-focus="focus" phx-blur="blur" phx-keyup="keyup" ... />
    ```
2.  **Events**:
    - Implement distinct `handle_event` callbacks for each binding.
    - Log the events to a list in the state to visualize them in real-time.

## Tips
- `phx-key` (not used here, but related) is widely used to capture specific keys on the *window*, whereas `phx-keyup` on an input captures typing within that input.

## Challenge
Log **Mouse Enter** and **Mouse Leave** events on the input container.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">&lt;div phx-mouseenter="mouse_enter" phx-mouseleave="mouse_leave"&gt; ... &lt;/div&gt;

def handle_event("mouse_enter", _, socket) do
  {:noreply, update(socket, :logs, &["Mouse Entered" | &1])}
end

def handle_event("mouse_leave", _, socket) do
  {:noreply, update(socket, :logs, &["Mouse Left" | &1])}
end</code></pre>
</details>
