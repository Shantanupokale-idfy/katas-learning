# Kata 90: Mapbox

## Overview
Interactive map with markers using LiveView and JavaScript interop.

## Key Concepts

### 1. Mapbox Integration
This kata demonstrates how to integrate mapbox functionality into a LiveView application.

### 2. JavaScript Hooks
```javascript
// assets/js/hooks.js
Hooks.Mapbox = {
  mounted() {
    // Initialize mapbox
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
  <div id="map-container" phx-hook="Mapbox">
    <!-- Mapbox content -->
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
def handle_event("map_action", params, socket) do
  # Process map action
  {:noreply, socket}
end
```

### State Management
- Track map state in socket assigns
- Sync state between client and server
- Handle edge cases

## Common Patterns

### Initialization
```elixir
def mount(_params, _session, socket) do
  {:ok, 
   socket
   |> assign(:map_ready, false)
   |> push_event("init_map", %{})}
end
```

### Cleanup
```elixir
def terminate(_reason, socket) do
  # Cleanup map resources
  :ok
end
```

## Real-World Usage
- Map integration
- Production-ready mapbox integration
- Error handling and validation
- Performance optimization

## Resources
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
- [Phoenix Hooks](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-js-interop-and-client-hooks)
- External library documentation (if applicable)

## Next Steps
1. Add proper JavaScript library integration
2. Implement full map functionality
3. Add error handling
4. Test edge cases
