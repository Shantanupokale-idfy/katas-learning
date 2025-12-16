# Kata 52: The Button

## Overview
Buttons are fundamental UI elements. Creating a reusable button component with variants, sizes, and states improves consistency.

## Key Concepts

### 1. Variants via Attributes
```elixir
attr :variant, :string, default: "primary", values: ["primary", "secondary", "danger"]
attr :size, :string, default: "md", values: ["sm", "md", "lg"]
attr :loading, :boolean, default: false
attr :disabled, :boolean, default: false
```

### 2. Dynamic Classes
```elixir
defp button_class(variant, size) do
  base = "rounded font-medium transition"
  variant_class = variant_classes(variant)
  size_class = size_classes(size)
  "#{base} #{variant_class} #{size_class}"
end
```

### 3. Loading State
```heex
<%= if @loading do %>
  <span class="spinner"></span>
<% else %>
  <%= render_slot(@inner_block) %>
<% end %>
```
