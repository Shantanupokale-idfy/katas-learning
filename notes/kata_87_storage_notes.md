# Kata 87: LocalStorage Persistence

## Goal
Persist data in the browser's `localStorage` so it survives page reloads.

## Core Concepts

### 1. Hook: `LocalStorage`
- `mounted()`: Read from storage, push to server (`pushEvent`).
- `handleEvent("save", ...)`: Write to storage.

## Implementation Details

1.  **Server**: `push_event("store", %{key: k, val: v})`.
2.  **Client**: `window.localStorage.setItem(key, val)`.

## Tips
- LiveView is server-side; it doesn't know about localStorage until the client tells it.

## Challenge
**Sync Across Tabs**.
In your Hook, add a `window.addEventListener("storage", ...)` listener.
When another tab updates storage, this event fires. Push the new data to the server so the UI updates instantly in all open tabs.

<details>
<summary>View Solution</summary>

<pre><code class="javascript">window.addEventListener("storage", e => {
  if (e.key === "my_app_data") {
    this.pushEvent("storage_updated", {val: e.newValue})
  }
})
</code></pre>
</details>
