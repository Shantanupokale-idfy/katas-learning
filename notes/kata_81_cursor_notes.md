# Kata 81: Live Cursor - Tutorial Notes

## Goal
Create a collaborative cursor tracking system where users can see each other's mouse positions in real-time. This demonstrates advanced PubSub usage with JavaScript hooks for client-side events.

## Problem Statement
Build a cursor tracking feature where:
- Users see cursors from other connected users
- Cursor positions update smoothly in real-time
- Each user has a unique color
- Cursor movements are throttled to avoid overwhelming the server
- Users don't see their own cursor (only others')

## Key Concepts

### 1. JavaScript Hooks for Mouse Tracking
Capture mouse movements on the client:
```javascript
export const CursorTracker = {
  mounted() {
    this.throttleMs = 50 // Max 20 updates per second
    
    this.handleMouseMove = (e) => {
      const now = Date.now()
      if (now - this.lastSent < this.throttleMs) return
      
      this.lastSent = now
      const rect = this.el.getBoundingClientRect()
      const x = e.clientX - rect.left
      const y = e.clientY - rect.top
      
      this.pushEventTo('#kata-sandbox', 'cursor-move', {x, y})
    }
    
    this.el.addEventListener('mousemove', this.handleMouseMove)
  }
}
```

### 2. Broadcasting Cursor Positions
Send cursor coordinates to all users:
```elixir
def handle_event("cursor-move", %{"x" => x, "y" => y}, socket) do
  Phoenix.PubSub.broadcast(
    ElixirKatas.PubSub,
    "cursor:demo",
    {:cursor_update, socket.assigns.username, x, y, socket.assigns.color}
  )
  {:noreply, socket}
end
```

### 3. Rendering Other Users' Cursors
Display cursors with user-specific colors:
```heex
<%= for {username, %{x: x, y: y, color: color}} <- @cursors do %>
  <div 
    class="absolute pointer-events-none transition-all duration-100"
    style={"left: #{x}px; top: #{y}px; color: #{color}"}
  >
    <svg class="w-6 h-6" fill="currentColor">
      <!-- Cursor SVG path -->
    </svg>
    <span class="text-xs ml-2"><%= username %></span>
  </div>
<% end %>
```

### 4. Event Forwarding in LiveComponents
Forward hook events from parent LiveView to LiveComponent:
```elixir
# In KataHostLive
def handle_event(event, params, socket) do
  if socket.assigns.dynamic_module do
    send_update(socket.assigns.dynamic_module, 
      id: "kata-sandbox", 
      event: event, 
      params: params)
  end
  {:noreply, socket}
end
```

## Implementation Steps

1. **Create JavaScript Hook**: Implement mouse tracking with throttling
2. **Initialize State**: Set up username, color, and cursors map
3. **Subscribe to Topic**: Join cursor tracking channel
4. **Handle Cursor Events**: Broadcast position updates
5. **Update Cursor Map**: Store other users' cursor positions
6. **Render Cursors**: Display SVG cursors at tracked positions
7. **Add Smooth Transitions**: Use CSS transitions for fluid movement

## Tips
- Throttle mouse events to 20-50ms for performance
- Use CSS transitions for smooth cursor movement
- Generate unique colors per user (hash username to HSL)
- Filter out your own cursor from the display
- Add cursor labels with usernames
- Consider adding cursor trails for visual effect

## Real-World Applications
- Collaborative design tools (Figma, Miro)
- Shared whiteboards
- Collaborative document editing
- Remote pair programming tools
- Interactive presentations
