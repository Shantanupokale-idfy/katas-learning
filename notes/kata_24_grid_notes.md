# Kata 24: The Grid

## Overview
Rendering lists as a grid (cards) rather than a table is a common pattern for "Gallery" views. CSS Grid makes this trivial, and LiveView can dynamically control the grid properties (like column count) via assigns.

## Key Concepts
1.  **CSS Grid**:
    - `display: grid`: Enables grid layout.
    - `gap-4`: Adds spacing between items.
    - `grid-template-columns`: The core property we manipulate.
    
2.  **Dynamic Styles**:
    - We can inject state into the `style` attribute directly for values that change frequently or are user-controlled (like column count).
    
    ```heex
    <div style={"grid-template-columns: repeat(#{@cols}, minmax(0, 1fr))"}>
      ...
    </div>
    ```

3.  **Responsive Design**:
    - While we manually set columns here, in a real app you might use Tailwind's responsive prefixes (e.g., `grid-cols-1 md:grid-cols-2 lg:grid-cols-3`). But user-controlled density is also a valid use case.

## Extensions
- Allow switching between "List View" (1 column, wide cards) and "Grid View" (multiple columns).
- Add sorting to the grid cards.
