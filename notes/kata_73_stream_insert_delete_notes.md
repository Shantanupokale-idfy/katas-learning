# Kata 73: Stream Insert/Delete

## Overview
Real-time stream updates

Real-time updates to streams without full page reload.

## Key Concepts
- `stream_insert` adds items
- `stream_delete` removes items
- Only diffs sent to client

## Pattern
1. Use stream for collection
2. Insert/delete as needed
3. DOM updates automatically
