# Kata 49: Translator (i18n)

## Goal
Implement a simple internationalization system. Switch languages to see UI text update instantly.

## Core Concepts

### 1. Translation Map
A simple Map `%{ "en" => %{"hello" => "Hello"}, "es" => ... }` simulates a real translation backend (like Gettext).

### 2. Helper Function
A `t(locale, key)` helper function looks up the string. If missing, it usually falls back to the key or a default language.

## Implementation Details

1.  **State**: `locale` (String "en", "es", ...).
2.  **Render**: All text is wrapped in `<%= t(@locale, "key") %>`.

## Tips
- Phoenix uses `Gettext` by default, which extracts strings to `.po` files. This kata simulates that mechanism in-memory.

## Challenge
Add a new language: **Italian** (`it`). Add the translations for "welcome" ("Benvenuto") and "greeting" ("Ciao, Mondo!").

<details>
<summary>View Solution</summary>

<pre><code class="elixir"># Add to @translations map:
"it" => %{
  "welcome" => "Benvenuto",
  "greeting" => "Ciao, Mondo!",
  ...
}
# Add button in render
</code></pre>
</details>
