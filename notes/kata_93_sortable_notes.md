# Kata 93: Sortable List

## Overview
Reorderable list items using LiveView and JavaScript interop.

## Key Concepts

### 1. Sortable List Integration
This kata demonstrates how to integrate sortable list functionality into a LiveView application.

### 2. JavaScript Hooks
```javascript
// assets/js/hooks.js
Hooks.SortableList = {
  mounted() {
    // Initialize sortable list
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
  <div id="sortable-container" phx-hook="SortableList">
    <!-- Sortable List content -->
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
def handle_event("sortable_action", params, socket) do
  # Process sortable action
  {:noreply, socket}
end
```

### State Management
- Track sortable state in socket assigns
- Sync state between client and server
- Handle edge cases

## Common Patterns

### Initialization
```elixir
def mount(_params, _session, socket) do
  {:ok, 
   socket
   |> assign(:sortable_ready, false)
   |> push_event("init_sortable", %{})}
end
```

### Cleanup
```elixir
def terminate(_reason, socket) do
  # Cleanup sortable resources
  :ok
end
```

## Real-World Usage
- Drag reordering
- Production-ready sortable list integration
- Error handling and validation
- Performance optimization

## Resources
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
- [Phoenix Hooks](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-js-interop-and-client-hooks)
- External library documentation (if applicable)

## Next Steps
1. Add proper JavaScript library integration
2. Implement full sortable functionality
3. Add error handling
4. Test edge cases
