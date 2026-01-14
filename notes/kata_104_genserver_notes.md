# Kata 104: GenServer Integration

## Overview

This kata demonstrates how to integrate GenServer workers with Phoenix LiveView for background job processing. It's a common pattern in production applications where you need process isolation, state management, and real-time updates.

## Why GenServers with LiveView?

**When to Use:**
- Background job processing (emails, image processing, reports)
- Maintaining shared state across multiple LiveView instances
- Rate limiting and throttling
- Caching with TTL
- Managing external connections (WebSockets, databases)

**Benefits:**
- **Process Isolation**: Crashes in GenServer don't crash LiveView
- **Supervision**: OTP supervisor restarts failed workers
- **State Management**: Single source of truth for complex state
- **Concurrency**: Handle requests asynchronously
- **Scalability**: Distribute work across processes

## Mental Model

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│  LiveView   │────────▶│  GenServer   │────────▶│   PubSub    │
│  Instance 1 │         │  (Job Queue) │         │             │
└─────────────┘         └──────────────┘         └─────────────┘
                               │                        │
                               ├─ Process Jobs          │
                               ├─ Maintain State        │
                               └─ Broadcast Updates ────┘
                                                         │
┌─────────────┐                                         │
│  LiveView   │◀────────────────────────────────────────┘
│  Instance 2 │         Real-time Updates
└─────────────┘
```

## Architecture

### 1. GenServer (Worker)
- Manages job queue state
- Processes jobs sequentially (or with configured concurrency)
- Broadcasts updates via PubSub
- Handles job lifecycle: pending → processing → completed/failed

### 2. LiveView (UI)
- Subscribes to PubSub topic
- Submits jobs to GenServer
- Receives real-time updates
- Renders job status and progress

### 3. PubSub (Communication)
- Decouples GenServer from LiveView
- Enables multiple LiveView instances to observe same state
- Allows other parts of the system to react to job events

## Key Implementation Details

### GenServer State Management

```elixir
state = %{
  jobs: %{},           # Map of job_id => job_data
  queue: [],           # List of pending job IDs
  processing: nil,     # Currently processing job ID
  next_id: 1          # Auto-increment ID
}
```

### Job Processing Flow

1. **Add Job**: Client calls `JobQueue.add_job/2`
2. **Queue**: Job added to queue with `:pending` status
3. **Process**: If no job processing, start next job
4. **Progress**: Worker spawns async task, sends progress updates
5. **Complete**: Mark as `:completed` or `:failed`, process next
6. **Broadcast**: All state changes broadcast via PubSub

### PubSub Integration

```elixir
# GenServer broadcasts
Phoenix.PubSub.broadcast(ElixirKatas.PubSub, @topic, {:queue_updated, status})

# LiveView subscribes
Phoenix.PubSub.subscribe(ElixirKatas.PubSub, @topic)

# LiveView receives
def handle_info({:queue_updated, status}, socket) do
  {:noreply, assign(socket, jobs: status.jobs, stats: status.stats)}
end
```

## Common Patterns

### 1. Rate Limiting

```elixir
defmodule RateLimiter do
  use GenServer
  
  def check_rate(user_id) do
    GenServer.call(__MODULE__, {:check, user_id})
  end
  
  def handle_call({:check, user_id}, _from, state) do
    # Check if user exceeded rate limit
    # Update state, return :ok or :rate_limited
  end
end
```

### 2. Cache with TTL

```elixir
defmodule Cache do
  use GenServer
  
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
  
  def put(key, value, ttl) do
    GenServer.cast(__MODULE__, {:put, key, value, ttl})
  end
end
```

### 3. Connection Pool

```elixir
defmodule PoolManager do
  use GenServer
  
  def checkout do
    GenServer.call(__MODULE__, :checkout)
  end
  
  def checkin(conn) do
    GenServer.cast(__MODULE__, {:checkin, conn})
  end
end
```

## Common Pitfalls

### ❌ Blocking Operations in GenServer

```elixir
# BAD: Blocks the GenServer
def handle_call(:process, _from, state) do
  result = expensive_operation()  # Blocks for minutes!
  {:reply, result, state}
end

# GOOD: Async processing
def handle_call(:process, _from, state) do
  Task.start(fn -> expensive_operation() end)
  {:reply, :accepted, state}
end
```

### ❌ Not Handling GenServer Crashes

```elixir
# BAD: No supervision
{:ok, pid} = GenServer.start_link(MyWorker, [])

# GOOD: Add to supervision tree
children = [
  {MyWorker, []}
]
```

### ❌ Message Bottlenecks

```elixir
# BAD: All LiveViews call GenServer for every update
def handle_event("update", _, socket) do
  data = GenServer.call(MyWorker, :get_data)  # Bottleneck!
end

# GOOD: Subscribe to PubSub, get push updates
def mount(_params, _session, socket) do
  Phoenix.PubSub.subscribe(MyApp.PubSub, "updates")
  {:ok, socket}
end
```

## Testing

### Testing GenServer

```elixir
test "processes jobs in order" do
  {:ok, _} = JobQueue.add_job("Job 1", 1)
  {:ok, _} = JobQueue.add_job("Job 2", 1)
  
  # Wait for first job to complete
  Process.sleep(1100)
  
  status = JobQueue.get_queue_status()
  assert status.stats.completed >= 1
end
```

### Testing LiveView Integration

```elixir
test "receives job updates", %{conn: conn} do
  {:ok, view, _html} = live(conn, "/katas/104-genserver")
  
  # Add job via GenServer
  {:ok, job_id} = JobQueue.add_job("Test", 1)
  
  # Verify LiveView receives update
  assert render(view) =~ "Test"
end
```

## Try It Out!

1. **Add jobs** with different durations
2. **Open multiple tabs** to see real-time sync
3. **Cancel jobs** while processing
4. **Monitor stats** updating in real-time
5. Check the **Source Code** tab to see implementation

## Further Reading

- [GenServer Documentation](https://hexdocs.pm/elixir/GenServer.html)
- [Phoenix.PubSub](https://hexdocs.pm/phoenix_pubsub/Phoenix.PubSub.html)
- [OTP Supervision](https://hexdocs.pm/elixir/Supervisor.html)
