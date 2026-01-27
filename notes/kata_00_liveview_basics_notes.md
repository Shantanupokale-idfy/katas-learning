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

Each LiveView is an **Elixir process** (a GenServer under the hood). It holds state, receives messages, and re-renders when state changes. If you understand `GenServer`, you already understand LiveView's core — it's just a process with a UI.

---

## 2. The Lifecycle (How It Starts)

A LiveView goes through two stages when you visit a page:

### Stage 1: The Dead Render (HTTP)
*   **Request**: You type `localhost:4000/` in the bar.
*   **Action**: `mount` runs. `render` runs.
*   **Result**: Full HTML is sent. Search engines see this. Users see this instantly (First Paint).
*   **Status**: Disconnected.

### Stage 2: The Live Connection (WebSocket)
*   **Action**: A tiny JS file (`live.js`) wakes up. It opens a WebSocket to the server.
*   **Action**: `mount` runs *again*. `render` runs *again*.
*   **Result**: The page is now "Live". Events work. State persists.
*   **Status**: Connected.

> **Key Insight**: `mount` runs **twice** — once for the static HTML (SEO-friendly, fast first paint) and once when the WebSocket connects. Never perform side-effects (like API calls or database writes) in `mount` unless you guard with `connected?(socket)`:
>
> ```elixir
> def mount(socket) do
>   if connected?(socket) do
>     # Safe to start timers, subscribe to PubSub, etc.
>   end
>   {:ok, assign(socket, count: 0)}
> end
> ```

---

## 3. The Update Loop (How It Stays Alive)

Once connected, LiveView enters a loop:

1.  **Event**: User clicks a button (`phx-click="increment"`).
2.  **Network**: The event name + payload is sent over the WebSocket.
3.  **Server**: The function `handle_event("increment", params, socket)` runs.
4.  **State Change**: You update assigns: `assign(socket, count: socket.assigns.count + 1)`.
5.  **Render**: LiveView re-runs `render/1`.
6.  **Diff**: It compares the *new* HTML with the *old* HTML.
    *   Old: `<span>Count: 1</span>`
    *   New: `<span>Count: 2</span>`
    *   Diff sent: just `"2"`
7.  **Patch**: The server sends only the changed parts to the browser.
8.  **DOM**: The browser patches the DOM. No full page reload.

This is why LiveView feels instant — it sends **diffs**, not full pages.

---

## 4. HEEx Templates

LiveView uses **HEEx** (HTML + Embedded Elixir) for templates. You'll write them using the `~H` sigil.

### Interpolation
Use curly braces `{}` to embed Elixir expressions:

```heex
<h1>Hello, {@name}!</h1>
<p>You have {length(@items)} items.</p>
```

`@name` is shorthand for `assigns.name`. You'll use `@` everywhere in templates to access assigns.

### Conditional Rendering with `:if`
```heex
<p :if={@show_message}>This only renders when @show_message is truthy.</p>

<div :if={@logged_in}>
  Welcome back!
</div>
```

For if/else, use a standard Elixir expression:
```heex
<span>
  {if @active, do: "ON", else: "OFF"}
</span>
```

### Looping with `:for`
```heex
<ul>
  <li :for={item <- @items}>{item.name}</li>
</ul>
```

### Dynamic Attributes
```heex
<!-- Dynamic CSS class -->
<div class={if @is_active, do: "text-green-500", else: "text-gray-400"}>
  Status
</div>

<!-- Class list (falsy values are filtered out) -->
<button class={["btn", @selected && "btn-primary"]}>Click</button>

<!-- Dynamic inline style -->
<div style={"background-color: rgb(#{@r}, #{@g}, #{@b})"}>
  Color Preview
</div>

<!-- Disabled attribute -->
<button disabled={@loading}>Submit</button>
```

### Pattern Matching / Case in Templates
```heex
<div>
  {case @tab do
    :home -> "Welcome home"
    :settings -> "Settings page"
    _ -> "Unknown"
  end}
</div>
```

---

## 5. The Three Core Callbacks

Every LiveView (and LiveComponent) is built from three callbacks.

### `mount/1` — Initialize State
Called when the component starts. Set your initial assigns here.

```elixir
def mount(socket) do
  {:ok, assign(socket, count: 0, name: "World")}
end
```

Returns `{:ok, socket}`.

### `render/1` — Produce HTML
Called every time assigns change. Returns a HEEx template.

```elixir
def render(assigns) do
  ~H"""
  <div>
    <h1>Hello, {@name}!</h1>
    <p>Count: {@count}</p>
    <button phx-click="increment" phx-target={@myself}>+1</button>
  </div>
  """
end
```

The `assigns` argument is a map. Inside `~H`, you access values with `@key`.

### `handle_event/3` — Respond to User Actions
Called when a user triggers an event (click, form change, keypress, etc.).

```elixir
def handle_event("increment", _params, socket) do
  {:noreply, update(socket, :count, &(&1 + 1))}
end
```

Arguments:
- **Event name** (string) — matches the `phx-click`, `phx-change`, etc. value.
- **Params** (map with string keys) — data sent with the event.
- **Socket** — current state.

Returns `{:noreply, socket}`.

---

## 6. The Socket & Assigns

The `socket` is your state container. All your data lives in `socket.assigns`.

### `assign/2` — Set Values
```elixir
# Set one or more assigns
socket = assign(socket, count: 0)
socket = assign(socket, name: "Ada", role: :admin)
```

### `update/3` — Transform an Existing Value
When the new value depends on the old value, use `update`:
```elixir
# Increment count based on current value
socket = update(socket, :count, &(&1 + 1))

# Append to a list
socket = update(socket, :logs, fn logs -> ["new entry" | logs] end)
```

### Reading Assigns
```elixir
# In Elixir code:
socket.assigns.count

# In HEEx templates:
{@count}
```

### Immutability
You never mutate the socket. Every function returns a **new** socket:
```elixir
# This does nothing (result is discarded):
assign(socket, count: 5)

# This works (pipe the result):
socket
|> assign(count: 5)
|> assign(name: "updated")
```

---

## 7. LiveView vs LiveComponent

This is an important distinction for these katas.

### LiveView
- A full page. Has its own URL/route.
- Mounted with `live "/path", MyLive`.
- Uses `mount/3` (receives params, session, socket).
- Has its own process.

### LiveComponent
- A **reusable piece** embedded inside a LiveView.
- Does **not** have its own process — it runs inside the parent LiveView's process.
- Uses `mount/1` (receives just the socket).
- Must use `phx-target={@myself}` to handle its own events.

**All katas in this project are LiveComponents.** They are hosted inside a parent `KataHostLive` view. This is why you'll see:

```elixir
use ElixirKatasWeb, :live_component
```

And why event handlers need `phx-target={@myself}`:

```heex
<!-- Without phx-target, the event goes to the PARENT LiveView -->
<button phx-click="increment">Goes to parent (wrong!)</button>

<!-- With phx-target={@myself}, the event stays in THIS component -->
<button phx-click="increment" phx-target={@myself}>Handled here (correct!)</button>
```

> **Rule for Katas**: Always add `phx-target={@myself}` to your event bindings. Without it, your events will be sent to the host view instead of your kata component, and nothing will happen.

---

## 8. Event Bindings

LiveView provides HTML attributes that wire user actions to server-side handlers.

### `phx-click` — Click Events
```heex
<button phx-click="increment" phx-target={@myself}>+1</button>
```
```elixir
def handle_event("increment", _params, socket) do
  {:noreply, update(socket, :count, &(&1 + 1))}
end
```

### `phx-change` — Form Input Changes
Fires on every keystroke / input change. The event params contain the form field values.
```heex
<form phx-change="validate" phx-target={@myself}>
  <input type="text" name="query" value={@query} />
</form>
```
```elixir
def handle_event("validate", %{"query" => query}, socket) do
  {:noreply, assign(socket, query: query)}
end
```

### `phx-submit` — Form Submission
Fires when the form is submitted (Enter key or submit button).
```heex
<form phx-submit="save" phx-target={@myself}>
  <input type="text" name="title" value={@title} />
  <button type="submit">Save</button>
</form>
```
```elixir
def handle_event("save", %{"title" => title}, socket) do
  {:noreply, assign(socket, title: title, saved: true)}
end
```

### `phx-value-*` — Passing Data with Events
Attach extra data to events using `phx-value-` prefixed attributes:
```heex
<button phx-click="delete" phx-value-id="42" phx-target={@myself}>
  Delete Item 42
</button>
```
```elixir
def handle_event("delete", %{"id" => id}, socket) do
  # id is "42" (always a string!)
  {:noreply, assign(socket, items: Enum.reject(socket.assigns.items, &(&1.id == id)))}
end
```

### `phx-debounce` — Rate Limiting
Prevents events from firing too rapidly:
```heex
<input phx-change="search" phx-debounce="300" name="q" />
```
This waits 300ms after the user stops typing before sending the event.

### Other Event Bindings
*   `phx-focus` / `phx-blur` — Input focus events.
*   `phx-keyup` / `phx-keydown` — Keyboard events (params include `%{"key" => "Enter"}`).
*   `phx-window-keyup` / `phx-window-keydown` — Keyboard events on the whole window.

---

## 9. Server-Side Messages with `handle_info/2`

Not all updates come from users. Sometimes the server sends messages to itself — for timers, PubSub broadcasts, or background task results.

```elixir
def mount(socket) do
  if connected?(socket) do
    # Send a :tick message to ourselves every second
    Process.send_after(self(), :tick, 1000)
  end
  {:ok, assign(socket, seconds: 0)}
end
```

Handle incoming messages with `handle_info/2`:
```elixir
def handle_info(:tick, socket) do
  # Schedule the next tick
  Process.send_after(self(), :tick, 1000)
  {:noreply, update(socket, :seconds, &(&1 + 1))}
end
```

> **Note**: In a LiveComponent, server messages go to the **parent LiveView**, not the component. The katas handle this for you via `update/2`. You'll see `handle_info` used in later katas (Kata 11+).

---

## 10. A Complete Example

Here's what a typical kata looks like — a simple counter component:

```elixir
defmodule ElixirKatasWeb.Kata02CounterLive do
  use ElixirKatasWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-4 p-8">
      <h2 class="text-2xl font-bold">Count: {@count}</h2>

      <div class="flex gap-2">
        <button
          phx-click="decrement"
          phx-target={@myself}
          class="btn btn-outline"
        >
          -1
        </button>
        <button
          phx-click="increment"
          phx-target={@myself}
          class="btn btn-primary"
        >
          +1
        </button>
      </div>

      <button
        :if={@count != 0}
        phx-click="reset"
        phx-target={@myself}
        class="btn btn-sm btn-ghost"
      >
        Reset
      </button>
    </div>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, count: 0)}
  end
end
```

Notice the pattern: **mount** sets initial state → **render** displays it → **handle_event** updates it → render runs again. That's the whole loop.

---

## 11. Common Gotchas

### Event Params Are Always String-Keyed Maps
When a user submits a form or sends event data, the params arrive as a map with **string keys**, never atom keys:
```elixir
# Correct
def handle_event("save", %{"name" => name}, socket)

# Wrong (will not match)
def handle_event("save", %{name: name}, socket)
```

### `phx-value-*` Values Are Always Strings
Even if you write `phx-value-id="42"`, the handler receives `%{"id" => "42"}` — a string. Convert explicitly:
```elixir
id = String.to_integer(params["id"])
```

### Don't Forget `phx-target={@myself}`
In these katas (LiveComponents), omitting `phx-target` sends events to the parent LiveView, not your component. Your `handle_event` won't fire. If your button "doesn't work", this is likely why.

### Assign Before You Access
If you use `{@foo}` in your template but never assigned `:foo` in `mount`, you'll get a `KeyError`. Always initialize all assigns in `mount`.

### Pipe Your Socket Transformations
```elixir
# Good — each step builds on the previous
def handle_event("submit", params, socket) do
  {:noreply,
   socket
   |> assign(submitted: true)
   |> assign(name: params["name"])
   |> update(:count, &(&1 + 1))}
end

# Bad — intermediate results are lost
def handle_event("submit", params, socket) do
  assign(socket, submitted: true)    # discarded!
  assign(socket, name: params["name"]) # discarded!
  {:noreply, update(socket, :count, &(&1 + 1))}
end
```

---

## 12. Quick Reference

| Concept | Code |
|---------|------|
| Set state | `assign(socket, key: value)` |
| Update state | `update(socket, :key, &(&1 + 1))` |
| Read state (Elixir) | `socket.assigns.key` |
| Read state (HEEx) | `{@key}` |
| Handle click | `phx-click="event_name"` |
| Handle form change | `phx-change="event_name"` |
| Handle form submit | `phx-submit="event_name"` |
| Pass data | `phx-value-id="42"` |
| Target component | `phx-target={@myself}` |
| Conditional render | `<div :if={@show}>...</div>` |
| Loop render | `<li :for={x <- @list}>{x}</li>` |
| Debounce input | `phx-debounce="300"` |

---

## 13. What's Next?

You now have the foundation to write LiveView code.

*   **Kata 01**: Write your first render and handle your first event.
*   **Kata 02**: Build a counter — learn `assign` vs `update`.
*   **Kata 03+**: Forms, conditional rendering, dynamic styles, timers, and beyond.

Click **Next Kata** in the sidebar to begin.
