# Kata 139: Virtual Scrolling

## Overview

Virtual scrolling is a performance optimization technique for rendering large lists efficiently. Instead of rendering all items in the DOM (which can cause serious performance issues), we only render the items currently visible in the viewport plus a small buffer.

## Why Virtual Scrolling?

**The Problem:**
- Rendering 10,000+ DOM nodes causes:
  - Slow initial page load
  - Laggy scrolling
  - High memory usage
  - Browser unresponsiveness

**The Solution:**
- Only render what's visible (~50-100 items)
- Dynamically update as user scrolls
 - Create illusion of full list with spacers
  - Smooth 60fps performance

## Mental Model

```
┌─────────────────────────────┐
│   Scroll Container          │
│                             │
│   ┌──── Spacer (virtual)───┐ ← Top offset
│   │                        │
│   │  [Item 45]  ◄───────────── Visible items (50)
│   │  [Item 46]             │
│   │  [Item 47]             │
│   │  ...                   │
│   │  [Item 94]             │
│   │                        │
│   └──── Spacer (virtual)───┘ ← Bottom offset
│                             │
└─────────────────────────────┘

Total items: 10,000
Rendered DOM nodes: ~50
Virtual list height: 10,000 × 80px = 800,000px
```

## Architecture

### 1. Server-Side (LiveView)

```elixir
@items_per_page 50
@item_height 80

# Track visible window
assign(:visible_start, 0)
assign(:visible_end, 50)
assign(:all_items, load_all_data())

# Render only visible slice
def visible_items(assigns) do
  Enum.slice(assigns.all_items, assigns.visible_start, @items_per_page)
end
```

### 2. Client-Side (JavaScript Hook)

```javascript
// Throttled scroll handler
handleScroll = () => {
  setTimeout(() => {
    pushEvent("scroll", {
      scrollTop: container.scrollTop
    })
  }, 16) // ~60fps
}
```

### 3. DOM Structure

```html
<div style="height: 600px; overflow-y: auto;">
  <!-- Total virtual height -->
  <div style="height: 800000px; position: relative;">
    <!-- Positioned content -->
    <div style="position: absolute; top: 3600px;">
      <!-- Only 50 items rendered -->
      <div>Item 45</div>
      <div>Item 46</div>
      ...
    </div>
  </div>
</div>
```

## Key Implementation Details

### Calculating Visible Window

```elixir
def handle_event("scroll", %{"scrollTop" => scroll_top}, socket) do
  # Which items are visible?
  visible_start = div(scroll_top, @item_height) - 5  # Buffer above
  visible_end = visible_start + @items_per_page + 10  # Buffer below
  
  {:noreply, assign(socket, visible_start: visible_start, visible_end: visible_end)}
end
```

**Why buffers?**
- Prevents white flashes during fast scrolling
- Gives time for LiveView round-trip
- Smoother user experience

### Performance Optimizations

1. **Throttling**: Limit scroll events to ~60fps (16ms)
2. **Buffers**: Render 5 items above/below viewport
3. **phx-update="ignore"**: Prevent LiveView from re-rendering scroll container
4. **Filtering Server-Side**: Filter on server, only send visible items
5. **CSS Height**: Use explicit heights for predictable layout

## Common Patterns

### Pattern 1: Infinite Scroll + Virtual Scrolling

```elixir
# Load data in chunks
def handle_event("load_more", _, socket) do
  new_items = fetch_next_page(socket.assigns.page)
  {:noreply, update(socket, :all_items, &(&1 ++ new_items))}
end
```

### Pattern 2: Search with Virtual Scrolling

```elixir
def handle_event("search", %{"query" => query}, socket) do
  filtered = Enum.filter(socket.assigns.all_items, &matches?(&1, query))
  
  {:noreply,
   socket
   |> assign(:filtered_items, filtered)
   |> assign(:visible_start, 0)  # Reset to top
  }
end
```

### Pattern 3: Dynamic Item Heights

```elixir
# For variable heights, track individual heights
defp calculate_offset(items, index) do
  items
  |> Enum.take(index)
  |> Enum.map(&item_height/1)
  |> Enum.sum()
end
```

## Common Pitfalls

### ❌ Not Using phx-update="ignore"

```elixir
# BAD: LiveView re-renders entire scroll container
<div id="scroll" phx-hook="VirtualScroll">

# GOOD: LiveView ignores this element
<div id="scroll" phx-hook="VirtualScroll" phx-update="ignore">
```

### ❌ Sending All Data Over Wire

```elixir
# BAD: Sending 10,000 items on every update
@impl true
def render(assigns) do
  # LiveView encodes ALL assigns
end

# GOOD: Only send visible slice
def visible_items(assigns) do
  Enum.slice(assigns.all_items, assigns.visible_start, @items_per_page)
end
```

### ❌ Not Throttling Scroll Events

```javascript
// BAD: Floods server with events
el.addEventListener('scroll', () => {
  pushEvent("scroll", { scrollTop })
})

// GOOD: Throttle to 60fps
setTimeout(() => pushEvent("scroll", { scrollTop }), 16)
```

### ❌ Forgetting to Reset on Filter

```elixir
# BAD: User filtered but still at item 5000
def handle_event("filter", params, socket) do
  {:noreply, assign(socket, :filtered_items, apply_filter(params))}
end

# GOOD: Reset scroll to top
{:noreply, 
 socket
 |> assign(:filtered_items, apply_filter(params))
 |> assign(:visible_start, 0)
 |> assign(:visible_end, @items_per_page)
}
```

## Testing

### Performance Testing

```elixir
test "only renders visible items" do
  {:ok, view, _html} = live(conn, "/katas/139-virtual-scrolling")
  
  html = render(view)
  
  # Should only have ~50 items in DOM
  item_count = html |> Floki.find(".item-row") |> length()
  assert item_count <= 60  # 50 + buffers
  assert item_count >= 40  # Account for buffer strategy
end
```

### Scroll Testing

```elixir
test "updates visible items on scroll" do
  {:ok, view, _html} = live(conn, "/katas/139-virtual-scrolling")
  
  # Scroll to middle
  render_hook(view, "scroll", %{"scrollTop" => "40000"})
  
  html = render(view)
  assert html =~ "Item 500"  # Middle of list
  refute html =~ "Item 1"    # Top not visible
end
```

## Real-World Applications

1. **E-commerce**: Product listings with thousands of items
2. **Social Media**: Infinite feed with millions of posts
3. **Data Tables**: Large datasets (logs, transactions)
4. **Chat Applications**: Long message history
5. **File Browsers**: Directories with many files

## Performance Metrics

**Without Virtual Scrolling (10,000 items):**
- DOM Nodes: 10,000+
- Initial Render: 3-5 seconds
- Memory: 150-200 MB
- Scroll FPS: 10-20fps (laggy)

**With Virtual Scrolling (10,000 items):**
- DOM Nodes: 50-60
- Initial Render: 50-100ms
- Memory: 20-30 MB
- Scroll FPS: 55-60fps (smooth)

## Further Reading

- [React Virtualized](https://github.com/bvaughn/react-virtualized)
- [Virtual Scrolling: Core Principles](https://blog.logrocket.com/virtual-scrolling-core-principles-and-basic-implementation-in-react/)
- [Phoenix LiveView Performance](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-performance-considerations)

## Try It Out!

1. **Scroll through 10,000 items** - Notice smooth performance
2. **Use filters** - Search, category, status
3. **Open DevTools** - Check DOM node count
4. **Compare to regular list** - Imagine rendering all 10,000!
5. **Check Network tab** - See minimal data transfer

This is how modern apps handle large datasets while staying responsive!
