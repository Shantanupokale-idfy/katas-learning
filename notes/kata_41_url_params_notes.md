# Kata 41: URL Params (Query String)

## Goal
Synchronize UI state with the URL Query String (e.g., `?filter=...`). This allows users to share links that preserve the application state.

## Core Concepts

### 1. `handle_params/3`
This callback is invoked after `mount` and whenever the URL changes (via `push_patch` or browser navigation). It is the ideal place to decode URL parameters into socket assigns.

### 2. `push_patch/2`
Updates the URL without reloading the page or remounting the LiveView. It triggers `handle_params`.

## Implementation Details

1.  **Events**:
    *   `set_filter`: Calls `push_patch(to: ~p"...?filter=X")`.
2.  **Callbacks**:
    *   `handle_params`: Reads separate `params["filter"]`, updates `@items`.

## Tips
- Always use `handle_params` for state that should be URL-addressable.
- Avoid updating `@items` in the click handler; let `handle_params` doing it ensures consistency even on "Back" button presses.

## Challenge
Add a **Sort Order** parameter (`?sort=asc` or `?sort=desc`) that sorts the items by name.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># 1. Update push_patch to include current filter AND new sort
# 2. In handle_params, read sort param and sort @items

def handle_params(params, _uri, socket) do
  sort = params["sort"] || "asc"
  # ... filtering ...
  sorted_items = if sort == "desc", do: Enum.sort(..., &>=/2), else: Enum.sort(...)
  {:noreply, assign(socket, items: sorted_items, sort: sort)}
end
</code></pre>
</details>
