# Kata 46: Search URL

## Goal
Combine Debounce with URL updates to create a search interface that is shareable. Type in the box -> Wait -> URL updates -> Results update.

## Core Concepts

### 1. Debounce + Push Patch
We want to update the URL, but not on *every* keystroke (too noisy).
- Input `phx-debounce="300"`.
- Event `search` calls `push_patch`.
- `handle_params` performs the search.

### 2. URI Encoding
Always encode parameters (`URI.encode/1`) when constructing URLs manually.

## Implementation Details

1.  **State**: `query`, `results`, `all_items`.
2.  **handle_params**:
    *   Read `q` param.
    *   Filter `all_items`.
    *   Assign `results`.

## Tips
- Verify that refreshing the page with the URL parameter keeps the search results active.

## Challenge
Add a **"Clear"** button (X) inside or next to the search input. It should clear the input AND remove the `?q=` parameter from the URL.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("clear", _, socket) do
  # Remove param by setting it to nil or empty? Usually omit it.
  {:noreply, push_patch(socket, to: ~p"/katas/46...")}
end
# In handle_params, handle missing "q" by showing all.
</code></pre>
</details>
