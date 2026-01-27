# Kata 82: Distributed Notifications (Toast)

## Goal
A notification system that can be triggered from anywhere in the cluster.

## Core Concepts

### 1. PubSub
Subscribe to `"notifications"`. Any process can `broadcast` a message here.

### 2. Auto Dismiss
Timers remove alerts after a few seconds.

## Implementation Details

1.  **State**: List of notifications `[{id, type, msg}]`.
2.  **Render**: Fixed position list (e.g., top-right).

## Tips
- Use unique IDs for notifications to ensure you dismiss the correct one.

## Challenge
Add **Actionable Notifications**. Support a notification that includes an action button, e.g., "Item Deleted. [Undo]".
You'll need to pass an event name or callback ref in the payload and handle the click.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># Payload: %{msg: "...", action: "undo_delete"}
# Render:
# if notif.action, do: <button phx-click={notif.action}>Undo</button>
</code></pre>
</details>
