# Kata 88: Theme Switcher

## Overview
Demonstrates theme switching (dark/light mode) with LiveView.

## Key Concepts

### 1. Theme State Management
```elixir
def mount(_params, _session, socket) do
  theme = get_session(socket, :theme) || "light"
  {:ok, assign(socket, :theme, theme)}
end
```

### 2. CSS Classes
```heex
<div class={if @theme == "dark", do: "bg-gray-900 text-white", else: "bg-white text-gray-900"}>
  Content
</div>
```

### 3. Persistence
```elixir
def handle_event("toggle_theme", _, socket) do
  new_theme = if socket.assigns.theme == "light", do: "dark", else: "light"
  {:noreply,
   socket
   |> assign(:theme, new_theme)
   |> put_session(:theme, new_theme)}
end
```

## Implementation Patterns

### Tailwind Dark Mode
```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  // ...
}
```

```heex
<html class={@theme}>
  <!-- Content automatically uses dark: variants -->
</html>
```

### System Preference
```javascript
// Detect system preference
const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
```

### LocalStorage Persistence
```javascript
Hooks.ThemeSwitcher = {
  mounted() {
    const theme = localStorage.getItem('theme') || 'light'
    this.pushEvent("set-theme", {theme})
    
    this.handleEvent("save-theme", ({theme}) => {
      localStorage.setItem('theme', theme)
      document.documentElement.classList.toggle('dark', theme === 'dark')
    })
  }
}
```

## Resources
- [Tailwind Dark Mode](https://tailwindcss.com/docs/dark-mode)
- [prefers-color-scheme](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme)
