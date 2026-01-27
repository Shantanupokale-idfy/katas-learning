# Kata 28: Radio Buttons

## Goal
Handle **Mutually Exclusive** choices.

## Core Concepts

### 1. Grouping
Radio buttons are grouped by sharing the same `name` attribute. Only one in the group can be checked.
`name="plan"`

### 2. Distinct Values
Each radio button has a fixed `value` attribute that differs from the others.
- `value="free"`
- `value="pro"`

### 3. Checked State
The one that matches the current form value gets `checked`.

```elixir
checked={@form[:plan].value == "pro"}
```

## Implementation Details

1.  **State**: `plan` (string, default "starter").
2.  **UI**: Three radio inputs sharing the same name but different values.
3.  **Events**: `validate` updates the selected plan.

## Tips
- Radio buttons are great for small sets of options (2-5). For larger sets, use a Select dropdown.

## Challenge
Make the **Enterprise** option **Disabled** so it cannot be selected.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">&lt;input ... value="enterprise" disabled={true} ... /&gt;
# OR if using .input component
&lt;.input ... options={[..., {"Enterprise", "enterprise", disabled: true}]} /&gt;</code></pre>
</details>
