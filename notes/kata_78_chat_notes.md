# Kata 78: Chat Room

## Goal
A shared chat room where users can send messages to each other.

## Core Concepts

### 1. Topic
`"chat:lobby"` or similar. Everyone subscribes to this.

### 2. Message Payload
`%{user: "Bob", text: "Hi"}`.
The LiveView appends this to its `@messages` list.

## Implementation Details

1.  **State**: `messages` (List), `username`.
2.  **Events**: `send_message` -> `broadcast`.
3.  **Info**: `handle_info` -> `update(socket, :messages, ...)`

## Tips
- Use `phx-update="stream"` for chat logs in production to handle thousands of messages efficiently. (Here a simple list is fine).

## Challenge
**Mentions**. If a message contains `@YourUsername`, modify the styling (e.g., yellow background) to highlight it for *that specific user*.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># In Render loop:
highlight = if String.contains?(msg.text, "@" <> @username), do: "bg-yellow-100", else: ""
<div class={highlight}>...</div>
</code></pre>
</details>
