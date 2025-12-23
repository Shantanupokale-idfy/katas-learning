# Kata 78: Chat Room - Tutorial Notes

## Goal
Build a real-time chat application where multiple users can send and receive messages instantly. This kata demonstrates Phoenix PubSub for broadcasting messages and handling multi-user interactions in LiveView.

## Problem Statement
Create a chat room where users can:
- Enter a username
- Send messages that appear instantly for all connected users
- See messages from other users in real-time
- Display timestamps for each message

## Key Concepts

### 1. Broadcasting Messages
Use PubSub to send messages to all subscribers:
```elixir
def handle_event("send_message", %{"message" => text}, socket) do
  Phoenix.PubSub.broadcast(
    ElixirKatas.PubSub,
    "chat:lobby",
    {:new_message, socket.assigns.username, text, DateTime.utc_now()}
  )
  {:noreply, socket}
end
```

### 2. Receiving Broadcast Messages
Handle incoming messages from other users:
```elixir
def handle_info({:new_message, username, text, timestamp}, socket) do
  message = %{username: username, text: text, timestamp: timestamp}
  messages = [message | socket.assigns.messages]
  {:noreply, assign(socket, messages: messages)}
end
```

### 3. Form Handling
Use `phx-submit` for message submission and clear input after sending:
```elixir
<form phx-submit="send_message">
  <input type="text" name="message" value={@current_message} 
         phx-change="update_message" autocomplete="off" />
  <button type="submit">Send</button>
</form>
```

## Implementation Steps

1. **Initialize State**: Set up username and empty messages list
2. **Subscribe to Chat Topic**: Join the chat room on mount
3. **Handle Message Submission**: Broadcast new messages to all users
4. **Display Messages**: Render messages with username and timestamp
5. **Clear Input**: Reset message input after sending

## Tips
- Limit message history to prevent memory issues (e.g., last 100 messages)
- Add message validation (non-empty, max length)
- Consider adding user colors for visual distinction
- Use `phx-hook` for auto-scrolling to latest message
- Format timestamps in a user-friendly way

## Real-World Applications
- Customer support chat
- Team collaboration tools
- Live event discussions
- Gaming chat systems
