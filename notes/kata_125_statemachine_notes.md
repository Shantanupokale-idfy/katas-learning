# Kata 125: State Machine with :gen_statem

In this kata, you will implement a **Vending Machine** using Elixir's `:gen_statem` behavior. While `GenServer` is the go-to for general state, `:gen_statem` provides a more robust framework for logic that naturally falls into discrete states and transitions.

## Why :gen_statem?

When building complex workflows (like a payment processor, a game engine, or a hardware controller), using a `GenServer` often leads to "conditional hell" — nested `case` or `if` statements checking the current state inside every `handle_call` or `handle_cast`.

`:gen_statem` formalizes this by:
- Explicitly defining **States** (e.g., `:idle`, `:ready`, `:dispensing`).
- Separating logic into state-specific handlers.
- Providing built-in support for **State Timeouts** and **Internal Transitions**.

## Key Concepts

### 1. States and Data
In `:gen_statem`, you manage both the **State** (the current mode of the machine) and the **Data** (the variables the machine needs, like balance or inventory).

### 2. State Enter Events
You can trigger logic immediately upon entering a new state. This is perfect for broadcasting updates or starting internal timers.

### 3. Transitions
A transition moves the machine from one state to another. You can return `{:next_state, :new_state, new_data}` to effect this change.

## Implementation Steps

1. **Define the behavior**: Use `@behaviour :gen_statem` and implement `callback_mode/0` (recommend `[:handle_event_function, :state_enter]`).
2. **Initialize**: Set the starting state and initial data.
3. **Handle Events**: Implement `handle_event/4`. Group your logic by state for better readability.
4. **Integration**: Connect your state machine to LiveView using `PubSub` to broadcast updates whenever the state changes.

## Try It Out!
- Insert coins to move the machine from `:idle` to `:ready`.
- Watch the **State Timeout** — if you don't select an item within 15 seconds, the machine will automatically return to `:idle` and "refund" your coins.
- Select an item when you have enough balance to see the `:dispensing` transition.
