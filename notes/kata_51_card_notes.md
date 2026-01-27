# Kata 51: Card Component

## Goal
Design a flexible Card component using **Multiple Named Slots**. This allows consumers to inject varying content into defined areas (Header, Body, Footer).

## Core Concepts

### 1. `render_slot(@name)`
Renders the content passed to a named slot.
```elixir
<:header>My Header</:header>
```

### 2. Conditional Slot Rendering
Check if a slot argument is present (not empty list) before rendering its container to avoid empty divs with padding.
```elixir
<%= if @header != [] do %> ... <% end %>
```

## Implementation Details

1.  **Slots**: `:header`, `:body`, `:footer`.
2.  **Usage**: Call `<.card>` and provide slot entries.

## Tips
- Named slots make your components much more reusable than passing huge strings of HTML as attributes.

## Challenge
Add **Collapsibility**. Add an `attr :collapsible, :boolean, default: false`. If true, clicking the header should toggle the visibility of the body/footer.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># 1. Add state `expanded` to component (if LiveComponent) or use JS command.
# 2. JS approach:
# <div class="header" phx-click={JS.toggle(to: "#body")}>...</div>
</code></pre>
</details>
