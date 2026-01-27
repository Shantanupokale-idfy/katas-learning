# Kata 61: Stateful Components

## Goal
Understand how `LiveComponent` manages its own isolated state, independent of the parent LiveView.

## Core Concepts

### 1. `mount/1` and `update/2`
LiveComponents have their own lifecycle. `mount` is called once (if stateful). `update` is called whenever the parent re-renders or `send_update` is used.

### 2. `@myself`
The specialized target that ensures events are sent to *this specific instance* of the component.

## Implementation Details

1.  **State**: `count`.
2.  **ID**: Crucial. Example uses `id="kata-61"`. Without an ID, a component is stateless.

## Tips
- Use stateful components for complex UI widgets (date pickers, rich text editors) that have internal logic not relevant to the page.

## Challenge
Add a **Reset** button that sets the count back to 0.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">def handle_event("reset", _, socket) do
  {:noreply, assign(socket, count: 0)}
end
</code></pre>
</details>
