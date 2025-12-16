# Kata 84: Accessible Focus

## Overview
Demonstrates proper focus management and ARIA attributes for creating accessible web applications.

## Key Concepts

### 1. Focus Management
- Programmatic focus control
- Visual focus indicators
- Keyboard navigation support

### 2. ARIA Attributes
```elixir
# ARIA labels for screen readers
<button aria-label="Close dialog">×</button>

# ARIA live regions for announcements
<div role="status" aria-live="polite">
  <%= @announcement %>
</div>

# ARIA states
<button aria-pressed={@is_pressed}>Toggle</button>
```

### 3. Focus Rings
```css
/* Visible focus indicators */
.focus:ring-2 .focus:ring-blue-500 .focus:ring-offset-2
```

## Implementation Details

### Screen Reader Support
- Use `aria-label` for descriptive labels
- Use `aria-live` regions for dynamic updates
- Use semantic HTML elements

### Keyboard Navigation
- All interactive elements focusable
- Logical tab order
- Visible focus indicators

### Focus Trapping
```elixir
# Trap focus within modal
def handle_event("open_modal", _, socket) do
  {:noreply, 
   socket
   |> assign(:modal_open, true)
   |> push_event("focus-first-element", %{selector: "#modal-content"})}
end
```

## Common Patterns

### Skip Links
```heex
<a href="#main-content" class="sr-only focus:not-sr-only">
  Skip to main content
</a>
```

### Focus After Actions
```elixir
# Return focus after closing modal
def handle_event("close_modal", _, socket) do
  {:noreply,
   socket
   |> assign(:modal_open, false)
   |> push_event("focus-element", %{id: "trigger-button"})}
end
```

## Resources
- [WAI-ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/)
- [WebAIM Accessibility](https://webaim.org/)
- [Phoenix LiveView Accessibility](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-accessibility)
