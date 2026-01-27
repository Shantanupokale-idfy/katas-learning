# Kata 43: Navbar Integration

## Goal
Build a navigation bar where the **active state** of links is determined by the current URL parameters.

## Core Concepts

### 1. Active Class Helper
Create a helper function (e.g., `active_class/2`) that takes the current page (from assigns) and the link target. If they match, return "active" CSS classes (bold, colored). If not, return "inactive" classes.

### 2. `patch` vs `navigate`
- `.link patch={...}`: updates URL, fires `handle_params`, keeps state.
- `.link navigate={...}`: full page transition (unmounts and remounts LiveView). Use this for major context switches.

## Implementation Details

1.  **State**: `current_page` (derived from params).
2.  **UI**: List of links. Call `active_class(@current_page, "home")` etc.

## Tips
- Encapsulate navigation logic in a reusable Functional Component (`<.nav_link ... />`) for consistency.

## Challenge
Add a **"Notifications"** badge that appears on the "Contact" link if the URL contains `?notify=true`.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># 1. In handle_params, track `notify` param.
# 2. In render:
&lt;.link ...&gt;
  Contact
  &lt;%= if @show_badge, do: &lt;span class="badge"&gt;1&lt;/span&gt; %&gt;
&lt;/.link&gt;
</code></pre>
</details>
