# Kata 22: The Highlighter

## Overview
This kata demonstrates how to manipulate text presentation based on user input, specifically highlighting substrings that match a search term. This is a common feature in search interfaces and document viewers.

## Key Concepts
1.  **State**:
    - `text`: The content to search within.
    - `search_term`: The user's input.
    
2.  **Text Processing**:
    - We need to find all occurrences of `search_term` in `text` and wrap them in a styling tag (like `<span class="highlight">`).
    - **Security**: When injecting HTML (like `<span>`), we must be careful. The safest way is to HTML-escape the original text *first*, then match/replace, and finally render using `raw/1`.

3.  **Regex**:
    - `Regex.compile!(Regex.escape(term), "i")` creates a case-insensitive regex safely.

## Implementation Details

```elixir
defp highlight_text(text, term) do
  safe_text = Phoenix.HTML.html_escape(text) |> Phoenix.HTML.safe_to_string()
  regex = Regex.compile!(Regex.escape(term), "i")
  
  String.replace(safe_text, regex, fn match -> 
    "<span class=\"bg-yellow-200\">#{match}</span>" 
  end)
end
```

In the template:
```heex
<%= raw(highlight_text(@text, @search_term)) %>
```
**Note**: `raw` tells Phoenix "I trust this string is safe HTML". Since we manually escaped the content before adding our trusted spans, this is effectively safe.
