# Kata 91: Masked Inputs

## Goal
Format user input automatically as they type (e.g., phone numbers, dates, credit cards).

## Core Concepts

### 1. `InputMask` Hook
A Hook that listens to `input` events and modifies `el.value` based on a pattern.

### 2. Data Attributes
Pass the mask type via `data-mask="phone"`.

## Implementation Details

1.  **Server**: Receives the *masked* value usually.
2.  **Unmasking**: Often you want to save raw numbers. You might need a hidden input or strip formatting on the server.

## Tips
- Accessibility: Ensure the screen reader announces the mask format or the label explains it.

## Challenge
Add a **ZIP Code** field.
Format: `99999` (5 digits).
Or `99999-9999` (ZIP+4).

<details>
<summary>View Solution</summary>

<pre><code class="html">
<.input ... data-mask="zip" />
<!-- Update JS Hook to handle "zip" case -->
</code></pre>
</details>
