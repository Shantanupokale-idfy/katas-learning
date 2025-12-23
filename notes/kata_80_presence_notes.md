# Kata 80: Presence List - Tutorial Notes

## Goal
Display a list of currently online users using Phoenix.Presence. This kata demonstrates how to track and display user presence across distributed nodes in real-time.

## Problem Statement
Build a "Who's Online" feature that:
- Shows all currently connected users
- Updates automatically when users join or leave
- Works across multiple server nodes (distributed)
- Displays user metadata (join time, status, etc.)

## Key Concepts

### 1. Phoenix.Presence
Presence tracks process state across a cluster:
```elixir
defmodule ElixirKatas.Presence do
  use Phoenix.Presence,
    otp_app: :elixir_katas,
    pubsub_server: ElixirKatas.PubSub
end
```

### 2. Tracking Users
Add users to presence when they connect:
```elixir
def mount(_params, _session, socket) do
  username = "User#{:rand.uniform(9999)}"
  
  if connected?(socket) do
    # Track this user's presence
    {:ok, _} = Presence.track(self(), "users:lobby", username, %{
      online_at: System.system_time(:second),
      username: username
    })
    
    # Subscribe to presence updates
    Phoenix.PubSub.subscribe(ElixirKatas.PubSub, "users:lobby")
  end
  
  {:ok, assign(socket, username: username, users: %{})}
end
```

### 3. Handling Presence Updates
React to users joining and leaving:
```elixir
def handle_info(%{event: "presence_diff", payload: diff}, socket) do
  # Update the users list based on joins and leaves
  users = Presence.list("users:lobby")
  {:noreply, assign(socket, users: users)}
end
```

### 4. Listing Present Users
Get all currently online users:
```elixir
users = Presence.list("users:lobby")
|> Enum.map(fn {_id, %{metas: [meta | _]}} -> meta end)
```

## Implementation Steps

1. **Set Up Presence Module**: Create presence module in your application
2. **Add to Supervision Tree**: Start Presence in `application.ex`
3. **Track on Mount**: Add user to presence when LiveView connects
4. **Subscribe to Updates**: Listen for presence_diff events
5. **Display User List**: Render online users with metadata
6. **Handle Disconnects**: Presence automatically removes disconnected users

## Tips
- Use unique user IDs to handle multiple tabs from same user
- Display "online since" time using metadata
- Add user avatars or status indicators
- Consider adding user count badge
- Handle edge case of user refreshing (quick leave/join)

## Real-World Applications
- Online user lists in chat apps
- Collaborative editing (who's viewing/editing)
- Gaming lobbies
- Live event attendee lists
- Customer support availability
