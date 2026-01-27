# Kata 50: Components

## Goal
Build reusable **Function Components** using `attr` and `slot`.

## Core Concepts

### 1. Attributes (`attr`)
Define inputs for your component.
```elixir
attr :variant, :string, default: "primary"
```

### 2. Slots (`slot`)
Define areas where content can be injected.
```elixir
slot :inner_block, required: true
slot :header
```
Render with `<%= render_slot(@header) %>`.

## Implementation Details

1.  **Define**: `defp my_comp(assigns)`.
2.  **Use**: `<.my_comp variant="danger">Content</.my_comp>`.

## Tips
- Components are the building blocks of Phoenix 1.7+. Keep them stateless (functional) when possible.

## Challenge
Create a **<.alert>** component.
- `attr :type` (info, warning, error) - affects color.
- `slot :inner_block` - message content.
- Render it in the demo view.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">attr :type, :string, default: "info"
slot :inner_block
defp alert(assigns) do
  color = case @type do
    "error" -> "bg-red-100 text-red-800"
    _ -> "bg-blue-100 text-blue-800"
  end
  assigns = assign(assigns, :color, color)
  ~H"""
  &lt;div class={"p-4 rounded " <> @color}&gt;
    &lt;%= render_slot(@inner_block) %&gt;
  &lt;/div&gt;
  """
end
</code></pre>
</details>
