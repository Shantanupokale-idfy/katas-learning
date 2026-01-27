# Kata 44: Breadcrumbs

## Goal
Dynamically generate a **Breadcrumb Trail** (Home > Section > Page) based on the current URL state.

## Core Concepts

### 1. State Derivation
Breadcrumbs are purely a function of the current parameters. You don't need to store them in the database; just calculate them in `handle_params`.

### 2. List Construction
Build a list of tuples `[{Label, Path}]`. Iterate over this list to render the trail, separating items with a slash `/`.

## Implementation Details

1.  **Handle Params**:
    *   Start with `[{"Home", path}]`.
    *   If `section` exists, append it.
    *   If `page` exists, append it.
2.  **Render**: Loop and render links. The last item is usually just text (not a link).

## Tips
- Capitalize labels (`String.capitalize/1`) for better presentation.
- Ensure paths in the breadcrumb use `patch` to maintain SPA feel.

## Challenge
Allow a **Custom Root Name**. If the URL is `?root=Dashboard`, the first crumb should say "Dashboard" instead of "Home".

<details>
<summary>View Solution</summary>

<pre><code class="elixir">root_label = params["root"] || "Home"
base = [{root_label, ~p"/katas/44..."}]
</code></pre>
</details>
