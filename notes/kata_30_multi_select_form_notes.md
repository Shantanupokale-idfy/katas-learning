# Kata 30: The Multi-Select Form

## Goal
Handle selecting **multiple options** using the native HTML `<select multiple>`.

## Core Concepts

### 1. Array Params
To tell the browser (and server) that multiple values are allowed, append `[]` to the input name.
`name="interests[]"`

### 2. List Values
The form parameter will be a **list of strings**, not a single string.
`%{"interests" => ["coding", "music"]}`

### 3. Multiple Attribute
Add `multiple` to the select tag.

## Implementation Details

1.  **State**: `interests` (list of strings).
2.  **UI**: A `<select multiple>` element.
3.  **Events**:
    - `validate`: expects a list for the "interests" key.

## Tips
- Native multi-selects are often hard to use (require Ctrl/Cmd+Click). Consider using a custom checkbox list (Kata 23) for better UX unless the list is huge.
