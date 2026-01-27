# Kata 71: Streams

## Goal
Manage large collections of data efficiently using `stream`. Streams avoid keeping the entire list in the server memory and minimize data sent over the wire.

## Core Concepts

### 1. `stream/4`
Initializes a stream. Used in `mount` or `update`.
```elixir
stream(socket, :items, items)
```

### 2. `phx-update="stream"`
The DOM container must have this attribute and a unique ID.
Inside the container, each child must have an ID used by the stream.
```html
<div id="items" phx-update="stream">
  <div :for={{id, item} <- @streams.items} id={id}>...</div>
</div>
```

## Implementation Details

1.  **State**: `@streams.items` (not a list, but a stream struct).
2.  **Add**: `stream_insert(socket, :items, item)`.
3.  **Delete**: `stream_delete(socket, :items, item)`.

## Tips
- You cannot access `@streams.items` like a normal list (e.g., `length(@streams.items)` won't work). You must track counts separately if needed.

## Challenge
Implement **Update Name**. Add a button next to an item that uppercases its name.
You simply `stream_insert` the *same item* (same ID) with the new data. LiveView detects the ID matches and updates the DOM element in place.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("upcase", %{"id" => id}, socket) do
  # You need to fetch the item data from somewhere (DB or cache) since streams don't hold it.
  # For demo, recreate it or assume you have it.
  item = %{id: id, name: "UPDATED ITEM"}
  {:noreply, stream_insert(socket, :items, item)}
end
</code></pre>
</details>
