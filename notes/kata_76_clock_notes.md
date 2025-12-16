# Kata 76: The Clock

## Overview
Server-side interval updates using `Process.send_after/3`.

## Key Concepts
- Schedule recurring updates
- Update UI every second
- Clean up on unmount

## Pattern
1. Send message to self after delay
2. Handle message and update state
3. Schedule next update
