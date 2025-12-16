# Kata 91: Masked Input

## Overview
Phone/card number masking using LiveView and JavaScript interop.

## Key Concepts

### 1. Masked Input Integration
This kata demonstrates how to integrate masked input functionality into a LiveView application.

### 2. JavaScript Hooks
```javascript
// assets/js/hooks.js
Hooks.MaskedInput = {
  mounted() {
    // Initialize masked input
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
  <div id="masked-container" phx-hook="MaskedInput">
    <!-- Masked Input content -->
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
def handle_event("masked_action", params, socket) do
  # Process masked action
  {:noreply, socket}
end
```

### State Management
- Track masked state in socket assigns
- Sync state between client and server
- Handle edge cases

## Common Patterns

### Initialization
```elixir
def mount(_params, _session, socket) do
  {:ok, 
   socket
   |> assign(:masked_ready, false)
   |> push_event("init_masked", %{})}
end
```

### Cleanup
```elixir
def terminate(_reason, socket) do
  # Cleanup masked resources
  :ok
end
```

## Real-World Usage
- Input formatting
- Production-ready masked input integration
- Error handling and validation
- Performance optimization

## Resources
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
- [Phoenix Hooks](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-js-interop-and-client-hooks)
- External library documentation (if applicable)

## Next Steps
1. Add proper JavaScript library integration
2. Implement full masked functionality
3. Add error handling
4. Test edge cases
