# Kata 80: Presence (Who is Online?)

## Goal
Track and display currently connected users using `Phoenix.Presence`.

## Core Concepts

### 1. `Presence.track`
Registers the current process (user) under a key (username/ID).
Meta map stores extra info (online_at, device_type).

### 2. `Presence.list`
Returns the current list of online users.

### 3. `handle_info(%{event: "presence_diff"})`
Called whenever someone joins or leaves.

## Implementation Details

1.  **Mount**: Call `Presence.track`.
2.  **Info**: On diff, re-fetch list with `Presence.list` and update UI.

## Tips
- Presence is eventually consistent and highly scalable (CRDT based).

## Challenge
**Sort by Join Time**. Ensure the list is sorted so the newest users appear at the top (or bottom).

<details>
<summary>View Solution</summary>

<pre><code class="elixir">Enum.sort_by(users, & &1.joined_at, :desc)
</code></pre>
</details>
