# Kata 96: File Uploads

## Goal
Handle multi-file uploads with progress bars using `allow_upload`.

## Core Concepts

### 1. `allow_upload`
Configures constraints (max size, extensions, count).
`max_file_size: 10_000_000` (10MB).

### 2. Entries & Progress
Iterate over `@uploads.avatar.entries`.
Use `entry.progress` (0-100) to render a progress bar.

## Implementation Details

1.  **Drop & Select**: `<.live_file_input>`.
2.  **Consume**: `consume_uploaded_entries` in the save event moves the temp files to permanent storage.

## Tips
- Always handle `upload_errors` (e.g., "File too large") so the user knows why an upload failed.

## Challenge
**Clear All**.
Add a button to remove all selected files at once before uploading. This is useful if the user changes their mind about the entire batch.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("clear_all", _, socket) do
  # Cancel each entry
  entries = socket.assigns.uploads.avatar.entries
  socket = Enum.reduce(entries, socket, fn entry, acc -> 
    cancel_upload(acc, :avatar, entry.ref) 
  end)
  {:noreply, socket}
end
</code></pre>
</details>
