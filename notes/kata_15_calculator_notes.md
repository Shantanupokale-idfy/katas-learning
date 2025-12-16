# Kata 15: The Calculator

## The Goal
Build a functional basic calculator capable of addition, subtraction, multiplication, and division.

## Key Concepts
- **Complex State**: Managing multiple state pieces (`accumulator`, `operation`, `current display`, `new_entry_flag`) interacting with each other.
- **State Machine**: The logic resembles a state machine (e.g., entering number -> entering operation -> entering number -> evaluating).
- **Format Handling**: Handling Integer vs Float conversion and display formatting.

## The Solution
We maintain the "accumulator" (the result of the previous operation) and the "current operation".
When an operator is clicked:
1. If we were already building a number (`!new_entry`), we treat this as a chain calculation and evaluate the *pending* operation first.
2. We then store the result as the new accumulator and update the pending operator.

This allows chaning like `2 + 3 * 4` (evaluating strictly left-to-right as `(2+3)*4` in this simple implementation, or one step at a time).
