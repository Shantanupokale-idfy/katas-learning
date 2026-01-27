# Kata 85: Scroll to Bottom

## Goal
Keep a chat window scrolled to the latest message.

## Core Concepts

### 1. Scroll Hook
A Hook `mounted()` and `updated()` can set `el.scrollTop = el.scrollHeight`.

### 2. `phx-update="stream"`
When new items append, the Hook triggers.

## Implementation Details

1.  **Hook**: `ScrollToBottom`.
2.  **Logic**: On every update to the list container, scroll down.

## Tips
- Only auto-scroll if the user was *already* at the bottom. If they scrolled up to read history, don't yank them back down.

## Challenge
**Unread Indicator**. If the user is scrolled up and a new message arrives, don't auto-scroll. Instead, show a floating "⬇ New Message" button. Clicking it scrolls to bottom.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># Hook needs to track `isAtBottom`.
# If !isAtBottom on NewMsg, user event -> show badge.
# (This is mostly JS Hook logic).
</code></pre>
</details>
