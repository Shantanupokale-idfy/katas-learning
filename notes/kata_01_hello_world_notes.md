# Kata 01: Hello World

## Goal
Create a basic "Hello World" page using Phoenix LiveView. This introduces the core lifecycle of a LiveView component: mounting, rendering, and handling a basic event.

## Core Concepts

### 1. The ~H Sigil
LiveView uses the `~H` sigil to define HTML templates. It enforces well-formed HTML and allows for Elixir expression interpolation using `{ }`.

### 2. State (Assigns)
State is stored in `socket.assigns`. It is immutable. To change what the user sees, you must update the socket assigns.

### 3. Event Handling (`phx-click`)
The `phx-click` attribute binds a DOM click event to a server-side handler.

```html
<button phx-click="toggle">Click me</button>
```

In your LiveView, you handle this with `handle_event/3`:

```elixir
def handle_event("toggle", _params, socket) do
  {:noreply, assign(socket, clicked: true)}
end
```

## Implementation Details

1.  **Mount**: Initialize the state (`clicked: false`).
2.  **Render**: Display a welcome message and a button. Use an `if` expression to change the button text based on `@clicked`.
3.  **Handle Event**: Create a "toggle" event handler that flips the `clicked` state.

## Tips
- Use `assign(socket, key: value)` to set state.
- Use `update(socket, key, function)` to modify existing state.

## Challenge
Add a second button labeled "Reset" that sets the state back to `false` (shows "Hello World" again) when clicked.

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># In render
&lt;button phx-click="reset"&gt;Reset&lt;/button&gt;

# In module
def handle_event("reset", _params, socket) do
  {:noreply, assign(socket, clicked: false)}
end</code></pre>
</details>
