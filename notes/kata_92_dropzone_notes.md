# Kata 92: File Dropzone

## Goal
A drag-and-drop area for file uploads.

## Core Concepts

### 1. `phx-drop-target`
Points to the upload ref (`@uploads.files.ref`). LiveView handles the drag events (adding a `phx-drop-target` class on hover).

### 2. Styling
Use `.phx-drop-target` class to style the drop zone when a file is hovering over it (e.g., `border-indigo-500 bg-indigo-50`).

## Implementation Details

1.  **Upload Config**: `allow_upload(..., accept: :any)`.
2.  **Interactive**: Drag over -> Visual feedback -> Drop -> Show preview list.

## Tips
- Always validate `max_file_size` on the server.

## Challenge
**Image Preview**.
If the user drops an image, show a preview using standard `live_img_preview`.
You need to update `allow_upload` to accept `~w(.jpg .jpeg .png)` first.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">allow_upload(..., accept: ~w(.jpg .jpeg .png))
# Render:
<.live_img_preview entry={entry} />
</code></pre>
</details>
