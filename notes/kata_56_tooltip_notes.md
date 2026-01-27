# Kata 56: The Tooltip

## Overview
Create a tooltip that appears when hovering over an element, using **pure CSS** (no JavaScript or LiveView events).

## Key Concepts

### 1. The Group Pattern
To control the visibility of a child element (the tooltip) based on the state of a parent element (the button/container), we use Tailwind's group modifier.

- Add `group` to the parent container.
- Add `group-hover:visible` (and `group-hover:opacity-100`) to the child tooltip.

### 2. Positioning
The tooltip needs to be positioned relative to the trigger element.

- Parent: `relative`
- Tooltip: `absolute`, `bottom-full`, `left-1/2`, `-translate-x-1/2` (centers it above).

### 3. Transitions
For a polished feel, add a fade-in effect.

- Base state: `invisible`, `opacity-0`, `transition-all`, `duration-200`
- Hover state: `group-hover:visible`, `group-hover:opacity-100`

## Implementation Steps

1.  Wrap the button and the tooltip div in a container with `relative inline-block group`.
2.  Style the tooltip div to be hidden by default (`invisible opacity-0`).
3.  Add the hover classes to the tooltip (`group-hover:visible group-hover:opacity-100`).
4.  Add a small arrow using a rotated square or a border hack for extra flair.
