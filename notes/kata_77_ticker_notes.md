# Kata 77: The Ticker - Tutorial Notes

## Goal
Create a real-time stock price ticker that simulates stock price updates using Phoenix PubSub. This kata demonstrates how to broadcast data to multiple connected clients and handle real-time updates in LiveView.

## Problem Statement
Build a live stock ticker that displays simulated stock prices for multiple stocks (e.g., AAPL, GOOGL, MSFT). Prices should update automatically every few seconds, and all connected users should see the same updates in real-time.

## Key Concepts

### 1. Phoenix PubSub
Phoenix PubSub allows processes to subscribe to topics and receive broadcast messages:
```elixir
# Subscribe to the ticker topic
Phoenix.PubSub.subscribe(ElixirKatas.PubSub, "stock:ticker")

# Broadcast price updates
Phoenix.PubSub.broadcast(
  ElixirKatas.PubSub,
  "stock:ticker",
  {:price_update, stock, price}
)
```

### 2. Server-Side Intervals
Use `Process.send_after/3` to trigger periodic updates:
```elixir
def handle_info(:tick, socket) do
  # Broadcast new prices
  broadcast_price_updates()
  
  # Schedule next tick
  Process.send_after(self(), :tick, 2000)
  {:noreply, socket}
end
```

### 3. Handling Broadcast Messages
LiveView processes receive PubSub messages via `handle_info/2`:
```elixir
def handle_info({:price_update, stock, price}, socket) do
  stocks = update_stock_price(socket.assigns.stocks, stock, price)
  {:noreply, assign(socket, stocks: stocks)}
end
```

## Implementation Steps

1. **Initialize State**: Set up initial stock prices in `mount/3`
2. **Subscribe to PubSub**: Subscribe to the ticker topic when connected
3. **Start Ticker**: Use `Process.send_after` to trigger periodic updates
4. **Broadcast Updates**: Generate random price changes and broadcast them
5. **Update UI**: Handle incoming price updates and re-render the stock list

## Tips
- Use color coding (green/red) to show price increases/decreases
- Display percentage change alongside absolute price
- Consider adding a timestamp to show when prices were last updated
- Throttle updates to avoid overwhelming the UI

## Real-World Applications
- Stock market dashboards
- Cryptocurrency price trackers
- Live sports scores
- Real-time metrics monitoring
