# Kata 29: The Select

## Goal
Handle selection from a **Dropdown** list.

## Core Concepts

### 1. Options Helper
Values can be hardcoded `<option>` tags or generated dynamically.
`Phoenix.HTML.Form.options_for_select/2` is a standard helper that takes a list of options (tuples or simple values) and the currently selected value.

```elixir
options_for_select(["Admin", "User"], selected_value)
```

### 2. Single Value
A standard `<select>` sends a single string value for the chosen option.

## Implementation Details

1.  **State**: `role` (string), `country` (string).
2.  **UI**: Two select inputs. One manually built, one using the helper.
3.  **Events**: `validate` updates the selection.

## Tips
- Always provide a sensible default or a "Please select..." placeholder option with a nil/empty value.
