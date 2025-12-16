# Kata 51: The Card

## Overview
Cards are versatile containers for grouping related content. Using named slots allows flexible composition.

## Key Concepts

### 1. Named Slots
Define multiple slots for different sections:
```elixir
slot :header
slot :body
slot :footer

def card(assigns) do
  ~H"""
  <div class="card">
    <div class="header"><%= render_slot(@header) %></div>
    <div class="body"><%= render_slot(@body) %></div>
    <div class="footer"><%= render_slot(@footer) %></div>
  </div>
  """
end
```

### 2. Optional Slots
Check if slot content exists:
```elixir
<%= if @header != [] do %>
  <div class="header"><%= render_slot(@header) %></div>
<% end %>
```

### 3. Usage
```heex
<.card>
  <:header>Title</:header>
  <:body>Content</:body>
  <:footer>Actions</:footer>
</.card>
```
