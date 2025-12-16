# Kata 71: Streams Basic

## Overview
LiveView streams allow efficient handling of large collections by only sending changes to the client, not the entire list.

## Key Concepts

### 1. Stream Function
```elixir
stream(socket, :items, items)
```

### 2. Benefits
- Only sends diffs to client
- Efficient for large lists
- Automatic DOM updates

### 3. Usage in Template
```heex
<div id="items" phx-update="stream">
  <%= for {id, item} <- @streams.items do %>
    <div id={id}><%= item.name %></div>
  <% end %>
</div>
```

## Pattern
1. Initialize stream in mount
2. Use `stream_insert` to add items
3. Use `stream_delete` to remove items
4. Template uses `@streams.name`
