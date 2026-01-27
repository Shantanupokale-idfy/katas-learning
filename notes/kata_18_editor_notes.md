# Kata 18: The Editor

## Goal
Implement **Inline Editing**. Turn a text display into an input field when clicked, allowing immediate updates.

## Core Concepts

### 1. Edit Mode State
Track *which* item is being edited.
- `editing_id: "123"` -> Item 123 is in edit mode.
- `editing_id: nil` -> No item is being edited.

### 2. Conditional Swapping
Inside the loop, check if the current item is the one being edited.
- **If yes**: Render a form with an input.
- **If no**: Render the plain text with a click handler.

### 3. Auto-Focus
When swapping to an input, use the `autofocus` attribute (or a JS hook) so the user can type immediately.

## Implementation Details

1.  **State**: `items`, `editing_id`.
2.  **Events**:
    - `edit`: Sets `editing_id` to the item's ID.
    - `save`: Updates the item's text in the list and sets `editing_id` to `nil`.
    - `cancel`: Sets `editing_id` to `nil` (e.g., on blur).

## Tips
- Swapping the UI instantly creates a very interactive "app-like" feel.
- Using `phx-blur` on the input to trigger a "cancel" or "save" is a common pattern for inline editing.

## Challenge
Trigger edit mode on **Double Click** (`phx-dblclick`) of the text items, instead of using a specific "Edit" button/icon.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">&lt;div phx-dblclick="edit" phx-value-id={item.id}&gt;
  {item.text}
&lt;/div&gt;</code></pre>
</details>
