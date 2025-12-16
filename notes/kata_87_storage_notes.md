# Kata 87: Local Storage

## Overview
Demonstrates browser local storage for persisting data across sessions.

## Key Concepts

### 1. Local Storage API
```javascript
// JavaScript Hook
Hooks.LocalStorage = {
  mounted() {
    this.handleEvent("store", ({key, value}) => {
      localStorage.setItem(key, value)
    })
    this.handleEvent("load", ({key}) => {
      const value = localStorage.getItem(key)
      this.pushEvent("loaded", {key, value})
    })
  }
}
```

### 2. LiveView Integration
```elixir
def handle_event("save", %{"key" => key, "value" => value}, socket) do
  {:noreply, push_event(socket, "store", %{key: key, value: value})}
end
```

### 3. Data Persistence
- Survives page reloads
- Per-domain storage
- String-based key-value pairs

## Implementation Patterns

### Save Data
```elixir
def handle_event("save_preferences", prefs, socket) do
  {:noreply, push_event(socket, "store", %{
    key: "user_prefs",
    value: Jason.encode!(prefs)
  })}
end
```

### Load on Mount
```elixir
def mount(_params, _session, socket) do
  {:ok, push_event(socket, "load", %{key: "user_prefs"})}
end

def handle_event("loaded", %{"value" => value}, socket) when not is_nil(value) do
  prefs = Jason.decode!(value)
  {:noreply, assign(socket, :preferences, prefs)}
end
```

## Resources
- [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)
- [LiveView JS Interop](https://hexdocs.pm/phoenix_live_view/js-interop.html)
