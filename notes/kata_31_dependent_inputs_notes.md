# Kata 31: Dependent Inputs

## Goal
Build a form with cascading dropdowns, where options in one field depend on the selection in another (e.g., Country -> City).

## Core Concepts

### 1. State-Driven Options
The list of secondary options (Cities) is not static. It lives in `socket.assigns`. When the primary input (Country) changes, the server recalculates the available cities and pushes the update.

### 2. Resetting Logic
When the parent input changes, the child input usually becomes invalid. You must reset the child's value to prevent mismatched data (e.g., Country: USA, City: Berlin).

## Implementation Details

1.  **State**: `countries` (fixed list), `cities` (dynamic list), and `form`.
2.  **Events**:
    *   `handle_event("validate", ...)`:
        *   Detect if "country" changed.
        *   If yes, update `cities` assign and reset `city` value to empty.
        *   If no (only city changed), just update form state.

## Tips
- Use `Phoenix.HTML.Form.options_for_select/2` to easily generate `<option>` tags.
- Disabling the child input when the parent is empty improves UX.

## Challenge
Add a third level: **District**. It should depend on the selected **City**.
(You can mock the data, e.g., New York -> Manhattan, Brooklyn).

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># 1. Add `districts` to assigns (default [])
# 2. In handle_event "validate", if city changes, fetch districts.

defp get_districts("New York"), do: ["Manhattan", "Brooklyn", "Queens"]
defp get_districts(_), do: ["Downtown", "Uptown"]

# 3. Add Select in template:
# &lt;select name="district" disabled={@form[:city].value == ""} ...&gt;
</code></pre>
</details>
