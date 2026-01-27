# Kata 45: URL Tabs

## Goal
Implement a Tab interface where the active tab is controlled by the URL (`?tab=settings`).

## Core Concepts

### 1. Link-Based Tabs
Instead of `<button phx-click="set_tab">`, use `<.link patch={~p"...?tab=settings"}>`.
This makes tabs linkable, bookmarkable, and "Back" button friendly.

### 2. Fallback
If the `tab` parameter is missing, default to the first tab (e.g., "profile") in `handle_params`.

## Implementation Details

1.  **Handle Params**: Match `?tab=X` and update `@active_tab`.
2.  **Render**: Highlight the link corresponding to `@active_tab`. Render content block.

## Tips
- This is superior to state-only tabs for almost all main application navigation.

## Challenge
If the user visits the page **without** a tab parameter, automatically update the URL to include `?tab=profile` (using `push_patch` in handle_params) so the URL is always explicit.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_params(params, _uri, socket) do
  if params["tab"] do
    {:noreply, assign(socket, active_tab: params["tab"])}
  else
    # Normalize URL
    {:noreply, push_patch(socket, to: ~p"...?tab=profile")}
  end
end
</code></pre>
</details>
