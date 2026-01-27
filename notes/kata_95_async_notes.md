# Kata 95: Async Assigns

## Goal
Load data asynchronously without blocking the initial UI render.

## Core Concepts

### 1. `assign_async/3`
Starts a task. The `render` function receives an `AsyncResult` struct.

### 2. `<.async_result>`
Component to handle `:loading`, `:failed`, and success states declarative-style.
```elixir
<.async_result :let={data} assign={@my_data}>
  <:loading>Loading...</:loading>
  <:failed :let={reason}>Error: <%= reason %></:failed>
  <div><%= data %></div>
</.async_result>
```

## Implementation Details

1.  **Mount**: Call `assign_async`.
2.  **Function**: Returns `{:ok, %{key: val}}` or `{:error, reason}`.

## Tips
- Great for dashboards where one slow widget shouldn't stall the whole page.

## Challenge
Simulate **Failure**. Modify the loading function to randomly return `{:error, "Service Unavailable"}`. Observe the `:failed` slot rendering.

<details>
<summary>View Solution</summary>

<pre><code class="elixir">assign_async(..., fn ->
  if :rand.uniform(2) == 1, do: {:error, "Fail"}, else: {:ok, ...}
end)
</code></pre>
</details>
