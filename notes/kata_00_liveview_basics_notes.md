# Kata 00: LiveView Fundamentals

## The Concept
**Server-Side Rendering with Client-Side Dynamics**.
LiveView enables rich, real-time user experiences with server-rendered HTML.
It removes the need for complex client-side JavaScript frameworks (React/Vue) for 90% of use cases.

## The Architecture
1.  **Initial Load (HTTP)**: The browser requests the page. The server renders the FULL HTML frame. This is crucial for SEO and "Time to First Paint".
2.  **Connection (WebSocket)**: A tiny JS client (`live.js`) connects to the server via WebSocket.
3.  **The Loop**:
    *   **Event**: User clicks a button. JS sends payload to Server.
    *   **Update**: Server process (`GenServer`) handles event, updates state (`assigns`).
    *   **Diff**: Server calculates the *minimal* HTML difference (diff) needed.
    *   **Patch**: Server sends diff to Client. Client patches the DOM.

## Core Concepts

### 1. The Socket (`socket`)
The `socket` is the single source of truth. It holds the state (`assigns`).
It is immutable. Every operation (`assign`, `push_event`) returns a *new* socket.
```elixir
socket = assign(socket, count: 1)
```

### 2. Lifecycle Callbacks
*   **`mount(params, session, socket)`**: The "Constructor". Runs twice (once for HTTP, once for WS). Initialize state here.
*   **`handle_params(params, uri, socket)`**: runs after mount and whenever the URL updates (patch/navigate).
*   **`render(assigns)`**: The "View". A pure function returning HEEx. Automatically called when assigns change.

### 3. Event Handling
*   **`handle_event(name, params, socket)`**: Handles messages from the client (clicks, form changes).
*   **`handle_info(msg, socket)`**: Handles messages from other Elixir processes (PubSub, Timers).

## Deep Dive: Change Tracking
LiveView doesn't re-render the whole page. It uses explicit change tracking.
```elixir
<div id={@id} class="foo">{@count}</div>
```
If `@count` changes but `@id` doesn't, LiveView only sends the new number.
**Rule**: Only parts of the template relying on changed assigns are re-evaluated.

## Common Pitfalls

1.  **Latency**: Every interaction is a round-trip. While fast (typically <50ms), it's not "instant". For instant interactions (toggling menus), use **JS Commands** or hooks.
2.  **Memory**: Each user gets a process on the server. 100k users = 100k processes. While Erlang handles this well, storing huge datasets in `assigns` will consume RAM. Use `streams` for large lists (Kata 71).
3.  **Data Fetching**: Don't fetch data in `render`. Fetch in `mount` or `handle_params`. `render` should be pure and fast.

## Challenge
There is no code challenge for this Kata.
Proceed to **Kata 01** to write your first LiveView!
