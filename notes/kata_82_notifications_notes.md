# Kata 82: Distributed Notifications

## Overview
Demonstrates how to trigger and display notifications that could be broadcast across distributed nodes using Phoenix PubSub.

## Key Concepts

### 1. Notification System
- Trigger notifications from any part of the application
- Display notifications to users
- Dismiss individual or all notifications

### 2. Notification Types
- **Info**: Informational messages
- **Success**: Successful operations
- **Warning**: Warnings that need attention
- **Error**: Error messages

### 3. PubSub Pattern
In a real distributed system:
```elixir
# Subscribe to notifications
Phoenix.PubSub.subscribe(MyApp.PubSub, "notifications")

# Broadcast notification
Phoenix.PubSub.broadcast(
  MyApp.PubSub, 
  "notifications", 
  {:new_notification, notification}
)

# Handle broadcast
def handle_info({:new_notification, notif}, socket) do
  {:noreply, assign(socket, :notifications, [notif | socket.assigns.notifications])}
end
```

## Implementation Details

### State Management
- Notifications stored in socket assigns
- New notifications prepended to list (newest first)
- Each notification has type, message, and timestamp

### User Actions
- **Trigger**: Click buttons to create notifications
- **Dismiss**: Remove individual notifications
- **Clear All**: Remove all notifications at once

## Common Patterns

### Flash Messages vs Notifications
- **Flash**: One-time messages (redirects, form submissions)
- **Notifications**: Persistent, can accumulate, user-dismissible

### Real-World Usage
- System alerts
- User activity notifications
- Background job completions
- Cross-user notifications in collaborative apps

## Resources
- [Phoenix PubSub Documentation](https://hexdocs.pm/phoenix_pubsub/)
- [LiveView PubSub Guide](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-pubsub)
