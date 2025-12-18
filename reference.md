# Project Reference

This file serves as a central hub for navigating the project's documentation.

## Key Documents

- **[History](history.md)**: Tracks the progress of completed katas and infrastructure updates.
- **[Curriculum](curriculum.md)**: The master list of all 104 planned katas. Refers to this to pick the next task.
- **[Architecture](architecture.md)**: A guide to the application structure and a checklist for implementing new katas.

## Quick Links

- [Phoenix LiveView Katas Web Source](lib/elixir_katas_web)
- [LiveViews](lib/elixir_katas_web/live)
- [Router](lib/elixir_katas_web/router.ex)


## Completing the pending implementations
Implementation Plan: Advanced Katas with Real Libraries
Objective
Replace placeholder implementations in katas 89-100 with real, functional implementations using appropriate Elixir/Phoenix libraries.

Katas to Enhance
Kata 89: Chart.js Integration
Library: Contex (Elixir charting) or direct Chart.js via hooks Implementation:

Real data visualization
Multiple chart types (bar, line, pie)
Interactive data updates
Dynamic chart rendering
Kata 91: Masked Input
Library: Pure LiveView with JavaScript hooks Implementation:

Phone number masking (XXX) XXX-XXXX
Credit card masking XXXX-XXXX-XXXX-XXXX
Date masking MM/DD/YYYY
Real-time formatting as user types
Kata 94: Audio Player
Library: HTML5 Audio with LiveView controls Implementation:

Play/pause controls
Progress bar with seeking
Volume control
Time display
Sample audio file
Kata 96: File Uploads
Library: Phoenix.LiveView.Uploads (built-in) Implementation:

Drag & drop upload
Progress tracking
File validation
Multiple file support
Preview uploaded files
Kata 97: Image Processing
Library: Mogrify (ImageMagick wrapper) Implementation:

Image upload
Resize/crop operations
Format conversion
Thumbnail generation
Before/after preview
Kata 98: PDF Generation
Library: PdfGenerator or Gutenex Implementation:

Form inputs for PDF content
Generate PDF from data
Download functionality
Preview (if possible)
Kata 99: CSV Export
Library: NimbleCSV Implementation:

Sample data table
Export to CSV button
Download CSV file
Custom column selection
Kata 92: File Dropzone
Library: Phoenix.LiveView.Uploads Implementation:

Drag & drop zone
File list with remove
Upload progress
File type validation
Kata 93: Sortable List
Library: JavaScript hooks with SortableJS Implementation:

Drag to reorder
Visual feedback
Save order
Persist changes
Kata 90: Mapbox
Library: Leaflet.js (open source alternative) Implementation:

Interactive map
Add/remove markers
Click to add marker
Display coordinates
Kata 95: Async Assigns
Implementation: Pure LiveView

Async data loading
Loading states
Error handling
Retry mechanism
Kata 100: Error Boundary
Implementation: Pure LiveView

Trigger errors
Catch and display
Recovery options
Error logging
Dependencies to Add
# mix.exs
defp deps do
  [
    # Existing deps...
    {:mogrify, "~> 0.9.3"},           # Image processing
    {:pdf_generator, "~> 0.6"},       # PDF generation
    {:nimble_csv, "~> 1.2"}           # CSV parsing/generation
  ]
end
JavaScript Libraries (via CDN or npm)
Chart.js (for Kata 89)
SortableJS (for Kata 93)
Leaflet.js (for Kata 90)
Implementation Priority
Phase 1 - High Impact (Most useful):

Kata 96: File Uploads (built-in LiveView)
Kata 99: CSV Export (simple, useful)
Kata 91: Masked Input (common use case)
Phase 2 - Medium Complexity: 4. Kata 89: Chart.js (data visualization) 5. Kata 94: Audio Player (media control) 6. Kata 95: Async Assigns (loading patterns)

Phase 3 - Advanced: 7. Kata 97: Image Processing (requires Mogrify) 8. Kata 98: PDF Generation (requires library) 9. Kata 92: File Dropzone (similar to uploads)

Phase 4 - JavaScript Heavy: 10. Kata 93: Sortable List (requires SortableJS) 11. Kata 90: Mapbox/Leaflet (map integration) 12. Kata 100: Error Boundary (error handling)

Testing Strategy
Each kata will have working demo
Test with real data/files
Verify all interactive elements
Ensure proper error handling
