# Kata 26: The Text Input

## Goal
Understand the basics of **Forms** in LiveView: binding data, handling changes, and submitting.

## Core Concepts

### 1. The `.form` Component
Wraps the HTML `<form>` tag and handles events.
```elixir
<.form for={@form} phx-change="validate" phx-submit="save">
```

### 2. `phx-change`
Fires whenever usage input changes (e.g., typing). This allows for real-time validation or live previews.
- Even if you don't validate, you usually need this event to keep the server state in sync with the client input ("controlled inputs").

### 3. `to_form/1`
A helper that converts a map or changeset into a `Phoenix.HTML.Form` struct, which makes accessing nested errors and values easier in the template (`@form[:name]`).

## Implementation Details

1.  **State**: `form` (created via `to_form(%{"name" => ""})`).
2.  **UI**: Text input bound to the form field.
3.  **Events**:
    - `validate`: Updates the form state with the new values from the user.
    - `save`: Processes the final submission.

## Tips
- Always use `phx-submit` alongside `phx-change` to support creating a robust form experience (e.g. hitting Enter to submit).
