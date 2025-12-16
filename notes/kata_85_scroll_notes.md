# Kata 85: Scroll to Bottom

## Overview
Demonstrates auto-scroll functionality commonly used in chat interfaces and live feeds.

## Key Concepts

### 1. Auto-Scroll Pattern
Automatically scroll to bottom when new content appears.

### 2. JavaScript Hook
```javascript
// assets/js/hooks.js
let Hooks = {}

Hooks.ScrollToBottom = {
  mounted() {
    this.el.scrollIntoView({ behavior: "smooth" })
  },
  updated() {
    this.el.scrollIntoView({ behavior: "smooth" })
  }
}

export default Hooks
```

### 3. Integration
```elixir
# In your endpoint or app.js
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: {_csrf_token: csrfToken}
})
```

## Implementation Details

### Scroll Anchor
Place an element at the bottom that scrolls into view:
```heex
<div id="scroll-anchor" phx-hook="ScrollToBottom"></div>
```

### Conditional Auto-Scroll
```elixir
<%= if @auto_scroll do %>
  <div id="scroll-anchor" phx-hook="ScrollToBottom"></div>
<% end %>
```

### Manual Scroll
```elixir
def handle_event("scroll_to_bottom", _, socket) do
  {:noreply, push_event(socket, "scroll-to-bottom", %{})}
end
```

## Common Patterns

### Detect User Scroll
```javascript
Hooks.ChatScroll = {
  mounted() {
    this.el.addEventListener("scroll", () => {
      const isAtBottom = 
        this.el.scrollHeight - this.el.scrollTop === this.el.clientHeight
      this.pushEvent("scroll-position", { atBottom: isAtBottom })
    })
  }
}
```

### Preserve Scroll Position
```elixir
# Don't auto-scroll if user has scrolled up
def handle_event("new_message", msg, socket) do
  {:noreply,
   socket
   |> assign(:messages, [msg | socket.assigns.messages])
   |> assign(:should_scroll, socket.assigns.at_bottom)}
end
```

## Real-World Usage
- Chat applications
- Live feeds
- Log viewers
- Notification streams

## Resources
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
- [Phoenix Hooks](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-js-interop-and-client-hooks)
