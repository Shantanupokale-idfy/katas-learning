# Kata 32: Comparison Validation

## Goal
Validate that two inputs match (e.g., Password and Confirmation) and provide specific error messages when they don't.

## Core Concepts

### 1. Cross-Field Validation
Validation often depends on multiple fields. You can't just check `password` in isolation; you must compare it to `confirmation`.

### 2. Manual Error Injection
Phoenix forms usually get errors from Ecto Changesets. However, for simple LiveViews without schemas, you can manually inject errors into the `to_form(params, errors: ...)` function.

```elixir
errors = if pass != confirm, do: [confirmation: {"Mismatch", []}], else: []
to_form(params, errors: errors)
```

## Implementation Details

1.  **State**: Form with `password` and `confirmation`.
2.  **Events**:
    *   `handle_event("validate", ...)`: compare the two values.
    *   If they differ, add an error to the `confirmation` field.

## Tips
- Don't show the "Mismatch" error while the user is still typing the *first* field. Maybe wait until `confirmation` is not empty.

## Challenge
Add a **"Show Password"** checkbox that toggles the input type between `password` and `text` for both fields.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># State: show_password (bool)
# Template: type={if @show_password, do: "text", else: "password"}

def handle_event("toggle_visibility", _, socket) do
  {:noreply, update(socket, :show_password, &(!&1))}
end
</code></pre>
</details>
