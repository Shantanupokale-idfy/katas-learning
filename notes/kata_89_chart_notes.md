# Kata 89: Chart.js Integration

## Goal
Render interactive charts using a 3rd party JS library.

## Core Concepts

### 1. `phx-update="ignore"`
Crucial. The container `<canvas>` is managed by Chart.js. LiveView should never touch it after initial render, or it will destroy the chart instance.

### 2. Data Updates
To update the chart, the server pushes an event (`socket |> push_event("update_points", points)`).
The Hook listens (`handleEvent(...)`) and calls `chart.update()`.

## Implementation Details

1.  **Hook**: `ChartJS`.
2.  **Server**: `assign(socket, :data, ...)` (for initial) + `push_event`.

## Tips
- Never re-render the canvas element itself from the server.

## Challenge
Change **Chart Type**. Add a select menu or buttons to switch between "bar" and "line" charts.
You will need to destroy the old Chart instance in the Hook and create a new one with the new `type`.

<details>
<summary>View Solution</summary>

<pre><code class="javascript">handleEvent("change_type", ({type}) => {
  this.chart.destroy();
  this.chart = new Chart(ctx, {type: type, ...});
})
</code></pre>
</details>
