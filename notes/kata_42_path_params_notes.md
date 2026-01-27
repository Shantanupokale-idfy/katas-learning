# Kata 42: Path Params

## Goal
Handle dynamic route segments (e.g., `/items/:id`) to display specific resources.

## Core Concepts

### 1. Router Configuration
In `router.ex`, routes are defined like `live "/items/:id", ItemLive`. The `:id` portion is captured and passed to `handle_params`.

### 2. Selecting Data
Use the captured ID to look up the correct item from your data source (or assigns).

## Implementation Details

1.  **Mount**: Load the full list of items.
2.  **Handle Params**:
    *   Pattern match on `%{"id" => id}`.
    *   Set `@selected_item` based on the ID.
    *   Handle the case where ID is missing (index page) or invalid.

## Tips
- Parse IDs to integers if your data uses integer IDs (`String.to_integer/1`).
- Handle 404s or "Item not found" gracefully.

## Challenge
Add **Next / Previous** buttons that navigate to the next or previous item ID.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># In key places:
prev_id = @selected_item.id - 1
next_id = @selected_item.id + 1

# Render:
&lt;.link patch={~p"/katas/42.../#{prev_id}"}&gt;Prev&lt;/.link&gt;
&lt;.link patch={~p"/katas/42.../#{next_id}"}&gt;Next&lt;/.link&gt;
</code></pre>
</details>
