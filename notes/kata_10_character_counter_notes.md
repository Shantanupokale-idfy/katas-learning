# Kata 10: The Character Counter

## The Goal
Create a text input that tracks the specific number of characters typed by the user. It should validate this count against a predefined limit and provide visual feedback as the user approaches or exceeds that limit.

## Key Concepts
- **String Manipulation**: Using `String.length/1` to count characters (graphemes) correctly.
- **Computed Assigns (or Logic in Render)**: Calculating derived values (like `count_class` or `progress_color`) based on the current state.
- **Form Events**: Handling `phx-keyup` to capture keystrokes in real-time.

## The Solution
We store the text in the socket assigns. On every keyup event, we update this state.

```elixir
def handle_event("update_text", %{"value" => value}, socket) do
  {:noreply, assign(socket, text: value)}
end
```

In the template, we calculate the length dynamically:

```elixir
<span>{String.length(@text)} / {@limit}</span>
```

We also dynamically calculate CSS classes to give feedback:

```elixir
class={if String.length(@text) > @limit, do: "text-red-500", else: "text-gray-500"}
```

This ensures the UI is always a pure function of the application state.
