# Kata 83: The Game State

## Overview
Demonstrates shared game state management for a simple multiplayer game using LiveView.

## Key Concepts

### 1. Shared State
- Game state stored in LiveView process
- Multiple players can interact with same state
- Turn-based gameplay logic

### 2. State Synchronization
In a real multiplayer game:
```elixir
# Subscribe to game updates
Phoenix.PubSub.subscribe(MyApp.PubSub, "game:#{game_id}")

# Broadcast state changes
Phoenix.PubSub.broadcast(
  MyApp.PubSub,
  "game:#{game_id}",
  {:game_update, new_state}
)
```

### 3. Turn Management
- Track whose turn it is
- Disable actions for non-active player
- Switch turns after each action

## Implementation Details

### Game State
```elixir
%{
  player1_score: 0,
  player2_score: 0,
  current_turn: :player1,
  game_log: []
}
```

### Turn Logic
- Only active player can score
- Turn switches after each point
- Visual indicator shows active player

### Game Log
- Records all game actions
- Timestamped entries
- Scrollable history

## Common Patterns

### Multiplayer State Management
1. **Centralized State**: One LiveView holds authoritative state
2. **PubSub Broadcasting**: Changes broadcast to all connected players
3. **Optimistic Updates**: UI updates immediately, syncs with server

### Real-World Applications
- Turn-based games (chess, tic-tac-toe)
- Collaborative editing
- Real-time dashboards
- Auction systems

## Advanced Patterns

### Presence Tracking
```elixir
# Track connected players
Phoenix.Presence.track(self(), "game:#{id}", user_id, %{
  online_at: System.system_time(:second)
})
```

### State Persistence
```elixir
# Save game state to database
def handle_event("save_game", _, socket) do
  Games.update_game(socket.assigns.game_id, %{
    state: socket.assigns.game_state
  })
  {:noreply, socket}
end
```

## Resources
- [Phoenix Presence](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
- [LiveView State Management](https://hexdocs.pm/phoenix_live_view/)
- [Building Real-time Features](https://hexdocs.pm/phoenix/real_time.html)
