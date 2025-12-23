# Kata 86: Clipboard Copy - Tutorial Notes

## Goal
Implement a "Copy to Clipboard" feature using JavaScript interop. This kata demonstrates how to interact with browser APIs from LiveView using JavaScript hooks.

## Problem Statement
Create a copy-to-clipboard button that:
- Copies text to the system clipboard when clicked
- Shows visual feedback (success/error state)
- Works across different browsers
- Handles clipboard permissions gracefully

## Key Concepts

### 1. JavaScript Hooks
Use hooks to access browser APIs not available in Elixir:
```javascript
export const ClipboardCopy = {
  mounted() {
    this.el.addEventListener('click', () => {
      const text = this.el.dataset.clipboardText
      
      navigator.clipboard.writeText(text)
        .then(() => {
          this.pushEvent('clipboard-success', {})
        })
        .catch((err) => {
          this.pushEvent('clipboard-error', {error: err.message})
        })
    })
  }
}
```

### 2. Passing Data to Hooks
Use data attributes to pass text to the hook:
```heex
<button 
  phx-hook="ClipboardCopy"
  data-clipboard-text={@text_to_copy}
  id="copy-button"
>
  Copy to Clipboard
</button>
```

### 3. Handling Hook Responses
React to success/error events from JavaScript:
```elixir
def handle_event("clipboard-success", _params, socket) do
  {:noreply, put_flash(socket, :info, "Copied to clipboard!")}
end

def handle_event("clipboard-error", %{"error" => error}, socket) do
  {:noreply, put_flash(socket, :error, "Failed to copy: #{error}")}
end
```

### 4. Visual Feedback
Show temporary success state:
```elixir
def handle_event("clipboard-success", _params, socket) do
  socket = assign(socket, copied: true)
  Process.send_after(self(), :reset_copied, 2000)
  {:noreply, socket}
end

def handle_info(:reset_copied, socket) do
  {:noreply, assign(socket, copied: false)}
end
```

## Implementation Steps

1. **Create JavaScript Hook**: Implement clipboard API interaction
2. **Register Hook**: Add to app.js hooks object
3. **Add Button with Hook**: Create button with `phx-hook` attribute
4. **Pass Text via Data Attribute**: Use `data-clipboard-text`
5. **Handle Success/Error**: Show feedback to user
6. **Add Visual States**: Change button appearance on copy
7. **Reset State**: Clear success state after timeout

## Tips
- Use `navigator.clipboard.writeText()` for modern browsers
- Fallback to `document.execCommand('copy')` for older browsers
- Check clipboard permissions before attempting copy
- Provide clear visual feedback (icon change, color, message)
- Consider adding a tooltip showing "Copied!"
- Test on different browsers and devices

## Real-World Applications
- Code snippet sharing
- API key/token copying
- Share links
- Copy formatted text
- Export data as text
- Command-line instructions
