# Kata 27: The Checkbox

## Goal
Handle **Boolean** values in forms.

## Core Concepts

### 1. The Checkbox Quirk
HTML checkboxes do not send any value if unchecked.
- Phoenix generates a **hidden input** with a "false" value before the checkbox to ensure a value is always sent.

### 2. Casting Params
Form parameters are always strings (`"true"` / `"false"`).
- If using `Ecto.Changeset`, casting is automatic.
- If using raw maps, you must manually convert strings to booleans if needed.

## Implementation Details

1.  **State**: `newsletter` (bool), `terms` (bool).
2.  **UI**:
    - Checkbox for newsletter.
    - Checkbox for terms (required for submit).
3.  **Events**:
    - `validate`: Update state.
    - `submit`: Only allow if terms are accepted.

## Tips
- Use `Phoenix.HTML.Form.normalize_value("checkbox", val)` if you are manually building the input, but the standard `<.input>` component handles this for you.

## Challenge
Add a **"Select All"** checkbox that toggles both "Newsletter" and "Terms" at once.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("toggle_all", %{"value" => "true"}, socket) do
  # Set both to true
  {:noreply, assign(socket, form: to_form(%{"newsletter" => true, "terms" => true}))}
end</code></pre>
</details>
