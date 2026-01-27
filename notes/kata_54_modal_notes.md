# Kata 54: Modal Dialog

## Goal
Implement a generic Modal component that can overlay content and handle closing interactions.

## Core Concepts

### 1. Z-Index and Overlay
The modal needs a high `z-index` and a semi-transparent backdrop (`bg-black bg-opacity-50`).

### 2. Event Bubbling
Clicking the backdrop should close the modal. Clicking the *content* card should **not**.
Use `phx-click="prevent_close"` on the content container to stop the event from bubbling up to the backdrop's close handler.

## Implementation Details

1.  **State**: `show_modal` (boolean).
2.  **Events**:
    *   `close_modal`: Sets state to false.
    *   `prevent_close`: No-op (returns `{:noreply, socket}`).

## Tips
- Always provide a focus trap and accessibility attributes (ARIA) for real modals.

## Challenge
Support **Escape Key**. Add a window-level keydown listener to close the modal when `Esc` is pressed.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># On the modal container
&lt;div phx-window-keydown="close_modal" phx-key="Escape" ...&gt;
</code></pre>
</details>
