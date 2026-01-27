# Kata 00: LiveView Fundamentals

## The Missing Manual
Welcome to **Phoenix LiveView**.
This isn't just a library; it's a paradigm shift.
Most web frameworks (React, Vue, Svelte) run on the **Client**. LiveView runs on the **Server**.

Understanding this mental model is the key to everything that follows.

---

## 1. The Mental Model
In a traditional SPA (Single Page App):
1.  Browser downloads HTML + Huge JS Bundle.
2.  Browser calls API (JSON).
3.  Browser renders UI.

In **LiveView**:
1.  Browser downloads HTML (Instant).
2.  Browser connects a WebSocket.
3.  **Server** renders UI.
4.  **Server** pushes tiny HTML updates to Browser.

**You write code on the server, but it feels like it runs in the browser.**

---

## 2. The Lifecycle (How it starts)
A LiveView goes through two stages when you visit a page:

### Stage 1: The Dead Render (HTTP)
*   **Request**: You type `localhost:4000/` in the bar.
*   **Action**: `mount` runs. `render` runs.
*   **Result**: Full HTML is sent. Search engines see this. Users see this instantly (First Paint).
*   **Status**: Disconnected.

### Stage 2: The Live Connection (WS)
*   **Action**: A tiny JS file (`live.js`) wakes up. It opens a WebSocket to the server.
*   **Action**: `mount` runs *again*. `render` runs *again*.
*   **Result**: The page is now "Live".
*   **Status**: Connected.

> **Tip**: This is why `mount` runs twice! Don't perform expensive side-effects (like charging a credit card) in `mount` unless you check `connected?(socket)`.

---

## 3. The Loop (How it updates)
Once connected, the process is simple:

1.  **Event**: User clicks a button (`phx-click="inc"`).
2.  **Network**: The click event is sent over the wire.
3.  **Server**: The function `handle_event("inc", ...)` runs.
4.  **State Change**: You update the data: `assign(socket, count: 2)`.
5.  **Render**: LiveView re-runs `render`.
6.  **Diff**: It compares the *new* HTML with the *old* HTML.
    *   Old: `<div>Count is 1</div>`
    *   New: `<div>Count is 2</div>`
    *   Diff: `2` (It's that smart!)
7.  **Patch**: The server sends just the string "2" to the browser.
8.  **DOM**: The browser updates the text.

---

## 4. Key Concepts

### The Socket (`socket`)
The `socket` is your state container. It's a map that holds everything your view needs to know (`assigns`).
In Elixir, data is immutable. You never change the socket; you create a *new* socket with updated data.
```elixir
# Bad (Wont work)
socket.assigns.count = 2

# Good (Returns new socket)
assign(socket, count: 2)
```

### The T-G-T Stack
*   **Template (HEEx)**: The HTML with holes in it (`<div id={@id}>`).
*   **Game (GenServer)**: The logic process running on the server.
*   **Transport (WebSocket)**: The cable connecting them.

---

## 5. Attributes to Know
*   `phx-click`: Handles click events.
*   `phx-change`: Handles form input changes (keystrokes).
*   `phx-submit`: Handles form submission (Enter key).
*   `phx-value-*`: Passes data with events.
    *   `<button phx-click="delete" phx-value-id="42">` sends `{"id": "42"}` to the server.

---

## 6. What's Next?
You are now ready.
*   **Kata 01**: Will let you write your first Render.
*   **Kata 02**: Will let you handle your first Event.

Click **Next Kata** in the sidebar to begin your journey.
