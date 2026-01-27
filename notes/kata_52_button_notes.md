# Kata 52: Button Component

## Goal
create a robust **Button** component that handles variants (colors), sizes, and loading states uniformly across the application.

## Core Concepts

### 1. Attribute Defaults
Use `attr :variant, :string, default: "primary"` to enforce a standard look while allowing overrides.

### 2. Rest Attributes
Use `attr :rest, :global` to allow consumers to pass arbitrary HTML attributes (like `phx-click`, `data-foo`, `disabled`) without manually defining them all.

## Implementation Details

1.  **CSS Map**: Define functions or maps that translate abstract variants ("primary", "danger") into concrete Tailwind classes.
2.  **Loading State**: Automatically disable the button and show a spinner if `@loading` is true.

## Tips
- Centralizing button logic means you can update the design system (e.g., border radius) in one place.

## Challenge
Support **Links**. Add an `attr :to, :string, default: nil`. If `:to` is present, render a `.link` component (for navigation) instead of a `<button>`.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">defp btn(assigns) do
  if assigns[:to] do
    ~H"&lt;.link navigate={@to} class={...}&gt;...&lt;/.link&gt;"
  else
    ~H"&lt;button ...&gt;...&lt;/button&gt;"
  end
end
</code></pre>
</details>
