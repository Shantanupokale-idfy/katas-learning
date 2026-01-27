# Kata System Reference

This document outlines the architecture and structure of the Elixir Katas system.

## Core Architecture

 The Kata system is built around a dynamic `KataHostLive` LiveView that acts as a container for individual katas. It handles:
 1.  **Routing**: Resolves the requested kata ID (slug) to the corresponding source file.
 2.  **Compilation**: Dynamically compiles the kata code (from file or user-edited version).
 3.  **State Management**: Manages the state of the editor, tabs, and user session.

### File Structure

Each Kata consists of two main files:

1.  **Source Code (`lib/elixir_katas_web/live/kata_XX_name_live.ex`)**:
    *   Contains the `LiveComponent` logic for the kata.
    *   Must implement `mount/1`, `render/1`, and `handle_event/3`.
    *   This is what users edit in the "Source Code" tab.

2.  **Notes (`notes/kata_XX_name_notes.md`)**:
    *   Markdown file containing the description, instructions, and theory for the kata.
    *   Displayed in the "Description" tab.

## The 3-Tab Interface

The user interface is managed by `ElixirKatasWeb.KataComponents.kata_viewer/1` and consists of three main tabs:

### 1. Description
*   **Content**: Renders the markdown content from the corresponding `notes/kata_*_notes.md` file.
*   **Purpose**: Provides context, goals, and helpful information for the user.

### 2. Interactive (Live Playground)
*   **Content**: Renders the compiled `LiveComponent` of the kata.
*   **Mechanism**:
    *   The `KataHostLive` compiles the source code into a dynamic module.
    *   This module is rendered inside the host view using `<.live_component module={@dynamic_module} id="kata-sandbox" />`.
    *   It supports real-time updates as the user edits and saves code.

### 3. Source Code (Editor)
*   **Content**: A code editor (using `phx-hook="CodeEditor"`) showing the source of the kata.
*   **Features**:
    *   **Live Compilation**: Changes are sent to the server, compiled, and the "Interactive" tab updates immediately.
    *   **Persistence**: If a user is logged in, their changes are saved to the database (`user_katas` table).
    *   **Revert**: Users can revert their changes to the original file content.

## Creating a New Kata

To add a new kata (e.g., Kata 99: New Feature):

1.  **Create the Source File**:
    *   Path: `lib/elixir_katas_web/live/kata_99_new_feature_live.ex`
    *   Module: `ElixirKatasWeb.Kata99NewFeatureLive`
    *   Type: Must use `use ElixirKatasWeb, :live_component`

2.  **Create the Notes File**:
    *   Path: `notes/kata_99_new_feature_notes.md`
    *   Path: `notes/kata_99_new_feature_notes.md`
    *   Content: Markdown description of the task. Standard sections:
        *   **Goal**: What the user will build.
        *   **Core Concepts**: Theory and snippets.
        *   **Implementation Details**: Steps to build it.
        *   **Tips**: Helpful advice.
        *   **Challenge**: An extra task for the user.
            *   **View Solution**: Use the following HTML structure for hidden solutions:
                ```html
                <details>
                <summary>View Solution</summary>
                
                <pre><code class="elixir">def handle_event...
                </code></pre>
                </details>
                ```

The `KataHostLive` will automatically detect these files based on the file naming convention (`kata_ID_*`).
