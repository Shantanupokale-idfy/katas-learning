# Kata 89: Chart.js

## Overview
Chart display with sample data using LiveView and JavaScript interop.

## Key Concepts

### 1. Chart.js Integration
This kata demonstrates how to integrate chart.js functionality into a LiveView application.

### 2. JavaScript Hooks
```javascript
// assets/js/hooks.js
Hooks.Chart.js = {
  mounted() {
    // Initialize chart.js
    this.setup()
  },
  
  updated() {
    // Handle updates
  },
  
  destroyed() {
    // Cleanup
  }
}
```

### 3. LiveView Integration
```elixir
def render(assigns) do
  ~H"""
  <div id="chart-container" phx-hook="Chart.js">
    <!-- Chart.js content -->
  </div>
  """
end
```

## Implementation Details

### Setup
1. Add JavaScript library (if needed)
2. Create LiveView hook
3. Handle events between JS and LiveView

### Event Handling
```elixir
def handle_event("chart_action", params, socket) do
  # Process chart action
  {:noreply, socket}
end
```

### State Management
- Track chart state in socket assigns
- Sync state between client and server
- Handle edge cases

## Common Patterns

### Initialization
```elixir
def mount(_params, _session, socket) do
  {:ok, 
   socket
   |> assign(:chart_ready, false)
   |> push_event("init_chart", %{})}
end
```

### Cleanup
```elixir
def terminate(_reason, socket) do
  # Cleanup chart resources
  :ok
end
```

## Real-World Usage
- Data visualization
- Production-ready chart.js integration
- Error handling and validation
- Performance optimization

## Resources
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
- [Phoenix Hooks](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-js-interop-and-client-hooks)
- External library documentation (if applicable)

## Next Steps
1. Add proper JavaScript library integration
2. Implement full chart functionality
3. Add error handling
4. Test edge cases
