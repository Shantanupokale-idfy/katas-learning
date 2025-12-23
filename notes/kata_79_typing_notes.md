# Kata 79: Typing Indicator - Tutorial Notes

## Goal
Implement a "user is typing..." indicator that shows when other users are actively typing in a chat or form. This demonstrates ephemeral presence events using Phoenix PubSub.

## Problem Statement
Create a typing indicator system where:
- Users see when others are typing
- The indicator disappears after a few seconds of inactivity
- Multiple users can be typing simultaneously
- The indicator updates in real-time across all connected clients

## Key Concepts

### 1. Ephemeral Events
Typing indicators are temporary - they should disappear automatically:
```elixir
def handle_event("typing", %{"value" => _text}, socket) do
  # Broadcast typing event
  Phoenix.PubSub.broadcast(
    ElixirKatas.PubSub,
    "typing:demo",
    {:user_typing, socket.assigns.username}
  )
  
  # Cancel previous timer if exists
  if socket.assigns.timer_ref do
    Process.cancel_timer(socket.assigns.timer_ref)
  end
  
  # Set new timer to clear typing status
  timer_ref = Process.send_after(self(), :clear_typing, 3000)
  {:noreply, assign(socket, timer_ref: timer_ref)}
end
```

### 2. Managing Typing State
Track who is currently typing:
```elixir
def handle_info({:user_typing, username}, socket) do
  # Add user to typing set (excluding self)
  typing_users = if username != socket.assigns.username do
    MapSet.put(socket.assigns.typing_users, username)
  else
    socket.assigns.typing_users
  end
  
  {:noreply, assign(socket, typing_users: typing_users)}
end
```

### 3. Auto-Clear with Timers
Remove typing indicators after inactivity:
```elixir
def handle_info(:clear_typing, socket) do
  # Broadcast that user stopped typing
  Phoenix.PubSub.broadcast(
    ElixirKatas.PubSub,
    "typing:demo",
    {:user_stopped_typing, socket.assigns.username}
  )
  {:noreply, assign(socket, timer_ref: nil)}
end
```

## Implementation Steps

1. **Initialize State**: Set up username, typing users set, and timer reference
2. **Subscribe to Topic**: Join the typing events channel
3. **Handle Input Changes**: Broadcast typing events on `phx-change`
4. **Manage Timers**: Cancel old timers and set new ones on each keystroke
5. **Display Indicator**: Show "X is typing..." for active users
6. **Auto-Clear**: Remove users from typing list after timeout

## Tips
- Use `MapSet` for efficient add/remove of typing users
- Set timeout to 2-3 seconds for natural feel
- Don't show your own typing indicator
- Consider debouncing to reduce broadcast frequency
- Display multiple users gracefully ("Alice and Bob are typing...")

## Real-World Applications
- Chat applications (Slack, Discord)
- Collaborative document editing
- Form co-editing indicators
- Customer support systems
