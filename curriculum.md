# Phoenix LiveView Katas Curriculum: The 104

A comprehensive path to mastery. Target: Complete all 104 to become a LiveView Expert.

## Section 1: The Foundations (State & Events)
1.  **Hello World** (Static render, basic event) [DONE]
2.  **The Counter** (Integer state, click events, basic arithmetic) [DONE]
3.  **The Mirror** (Text input, `phx-change`, one-way binding) [DONE]
4.  **The Toggler** (Boolean state, conditional rendering, CSS classes)
5.  **The Color Picker** (Multiple state values `r, g, b`, style bindings)
6.  **The Resizer** (Integer state controlling element width/height)
7.  **The Spoiler** (Hidden content revealed on click)
8.  **The Accordion** (List state, expanding/collapsing multiple items)
9.  **The Tabs** (Switching content based on active tab state)
10. **The Character Counter** (String length calculation, limits validation)
11. **The Stopwatch** (`Process.send_after` interval, formatting time)
12. **The Timer** (Countdown, handling 0, stopping/resetting)
13. **Events Mastery** (`phx-keyup`, `phx-window-keydown`, `phx-blur`, `phx-focus`)
14. **Keybindings** (Global keyboard shortcuts for actions)
15. **The Calculator** (Complex accumulated state, operation logic)

## Section 2: Lists & Data Structures
16. **The List** (Rendering lists with `for`, appending items)
17. **The Remover** (Removing items from a list by ID)
18. **The Editor** (Editing a specific item in a list)
19. **The Filter** (Filtering a list based on text input)
20. **The Sorter** (Sorting a list by different fields)
21. **The Paginator** (Simple offset-based pagination logic)
22. **The Highlighter** (Search term highlighting within text)
23. **The Multi-Select** (Selecting multiple items from a list, `MapSet`)
24. **The Grid** (Rendering data in a grid layout)
25. **The Tree** (Recursive rendering of nested data structures)

## Section 3: Forms & Changesets
26. **The Text Input** (Basic form structure, `phx-submit`)
27. **The Checkbox** (Boolean mapping, "agree to terms")
28. **Radio Buttons** (Mutually exclusive selection logic)
29. **The Select** (Dropdowns, default values, option rendering)
30. **The Multi-Select Form** (Handling list values in forms)
31. **Dependent Inputs** (Country -> City dynamic dropdowns)
32. **Comparison Validation** (Password vs Confirm Password)
33. **Formats** (Email, Phone number regex validation)
34. **Live Feedback** (Showing errors only after "touching" input)
35. **Form Restoration** (Recovering input on crash/reconnect)
36. **Debounce & Throttle** (Optimizing search and auto-save)
37. **The Wizard** (Multi-step form wizard, keeping state via assigns)
38. **The Tag Input** (Custom component input for list of tags)
39. **The Rating Input** (Star rating custom form control)
40. **The Range Slider** (Dual handle slider custom control)

## Section 4: Routing, Navigation, & i18n
41. **URL Params** (Handling `handle_params` and query strings)
42. **Path Params** (Dynamic route segments `/user/:id`)
43. **The Nav Bar** (Active link highlighting based on current URI)
44. **The Breadcrumb** (Dynamic navigation hierarchy based on path)
45. **Tabs with URL** (syncing tab state to URL query params)
46. **Search with URL** (Deep linking search results)
47. **Protected Routes** (Redirecting unauthenticated users event in `on_mount`)
48. **Live Redirects** (`push_navigate` vs `push_patch`)
49. **The Translator (i18n)** (Switching locales, formatting dates/numbers)

## Section 5: Components & UI Patterns
50. **Functional Components** (Refactoring UI into `attr` and `slot`)
51. **The Card** (Slots for header, body, footer)
52. **The Button** (Variants, sizes, loading states)
53. **The Icon** (Wrapping SVG libraries)
54. **The Modal** (Global UI state, JS commands for show/hide)
55. **The Slide-over** (Drawer component, transition animations)
56. **The Tooltip** (CSS-only vs JS-positioned tooltips)
57. **The Dropdown** (Menu handling, click-outside detection)
58. **Flash Messages** (Custom flash component, auto-dismissing toast)
59. **The Skeleton** (Loading state placeholders)
60. **The Progress Bar** (Server-driven progress updates)

## Section 6: LiveComponents & Isolation
61. **Stateful Component** (`LiveComponent` lifecycle, `mount` vs `update`)
62. **Component ID** (Managing unique IDs for reusability)
63. **Send Update** (Parent updating child state)
64. **Send Self** (Child updating its own state)
65. **Child-to-Parent** (Sending messages up via `send(self(), ...)`)
66. **Sibling Communication** (Communicating via parent coordinator)
67. **Lazy Loading** (Loading heavy components asynchronously)

## Section 7: Data Integration (Ecto & Streams)
68. **Changesets 101** (Schema-less changesets for pure forms)
69. **The CRUD** (Full Create, Read, Update, Delete with DB)
70. **Optimistic UI** (Updating UI before server confirms)
71. **Streams Basic** (Handling large lists with `stream`)
72. **Infinite Scroll** (Streams + JS Hook for scroll detection)
73. **Stream Insert/Delete** (Real-time updates to stream)
74. **Stream Reset** (Clearing and repopulating streams)
75. **Bulk Actions** (Selecting streams inputs and acting on them)

## Section 8: Real-Time & PubSub
76. **The Clock** (Server-side interval updates)
77. **The Ticker** (Simulated stock price updates via PubSub)
78. **Chat Room** (Broadcasting messages to a topic)
79. **Typing Indicator** (Ephemeral presence events)
80. **Presence List** (Who is online? `Phoenix.Presence`)
81. **Live Cursor** (Broadcasting mouse coordinates)
82. **Distributed Notifications** (Triggering alerts from another node)
83. **The Game State** (Shared state for a simple multiplayer game)

## Section 9: JavaScript Interop (Hooks)
84. **Accessible Focus** (Managing focus after updates, aria-live regions)
85. **Scroll to Bottom** (Chat auto-scroll hook)
86. **Clipboard Copy** (Writing to system clipboard)
87. **Local Storage** (Syncing assigns to browser storage)
88. **Theme Switcher** (JS-driven dark/light mode persistence)
89. **Chart.js** (Pushing data to external charting lib)
90. **Mapbox** (Controlling map markers from server)
91. **Masked Input** (Formatting phone numbers/credit cards on client)
92. **File Dropzone** (Drag and drop events for uploads)
93. **Sortable List** (Drag and drop list reordering with SortableJS)
94. **Audio Player** (Controlling HTML5 audio from server)

## Section 10: Advanced & System Mastery
95. **Async Assigns** (`assign_async` for non-blocking UI)
96. **File Uploads** (Cloud storage, progress tracking, validation)
97. **Image Processing** (Resizing uploads on the fly)
98. **PDF Generation** (Generating and streaming downloadable files)
99. **CSV Export** (Streaming large data exports)
100. **Error Boundary** (Handling crashes gracefully)
101. **LiveView Testing** (Unit testing views and events)
102. **Integration Testing** (Wallaby/Playwright E2E tests)
103. **The Final Project** (Collaborative Kanban Board)
104. **GenServer Integration** (Background workers with LiveView) [DONE]
125. **State Machine** (Complex workflows with :gen_statem) [DONE]
139. **Virtual Scrolling** (Efficient rendering of 10,000+ items) [DONE]

