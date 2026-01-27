# Kata 47: Protected Routes

## Goal
Simulate authentication logic in LiveView. Show different content based on user state (`authenticated: true/false`).

## Core Concepts

### 1. Conditional Rendering
Use `<%= if @authenticated do %>` to swap entire UI blocks.

### 2. Real World Security
In a real app, this logic belongs in `on_mount` hooks in `router.ex`. If a user is not logged in, you `redirect` them to a login page *before* the LiveView even mounts.

## Implementation Details

1.  **State**: `authenticated` (Boolean).
2.  **Events**:
    *   `login`: Set true.
    *   `logout`: Set false.

## Tips
- Always check permissions on the server. Hiding a button via CSS is not security.

## Challenge
Add a **Role** check. Add a "Login as Admin" button. Only show a specific "Admin Panel" section if the user is authenticated AND has the role `:admin`.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># State: role (:user or :admin)
# Render:
# <%= if @role == :admin do %> ... <% end %>
</code></pre>
</details>
