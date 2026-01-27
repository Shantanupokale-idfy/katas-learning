# Kata 48: Redirects

## Goal
Understand the difference between `push_patch` and `push_navigate`.

## Core Concepts

### 1. `push_patch`
- **Same LiveView**.
- Updates URL.
- Calls `handle_params`.
- **Fast**. Use for tabs, filters, specific resource IDs in the same list.

### 2. `push_navigate`
- **Different LiveView** (or force reload).
- Unmounts current view, mounts new one.
- **Slower** (comparatively). Use for changing pages.

## Implementation Details

1.  **Events**: Buttons triggering both types of navigation.
2.  **Observation**:
    *   `push_patch`: Counter increments, socket PID stays same.
    *   `push_navigate`: Page flashes/reloads content, socket PID changes.

## Tips
- If you `push_patch` to a route handled by a *different* LiveView, it will crash or fail. You *must* use `push_navigate` for that.

## Challenge
Add a button that uses `push_patch` with `replace: true`. Verify that clicking it updates the URL but **does not** add a new entry to the browser's Back history stack (i.e., clicking Back takes you comfortably to the page before).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("replace_demo", _, socket) do
  {:noreply, push_patch(socket, to: ~p"...", replace: true)}
end
</code></pre>
</details>
