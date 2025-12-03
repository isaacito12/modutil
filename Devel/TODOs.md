# To-Do's

## PhysicalValueUI

Improve the inline error reporting.

- The current inline error reporting hides the Unit UI, which can be a problem
  if the error requires changing the unit to fix it.
- Consider using the Name UI instead to report errors.
  For example, use the right side of the Name UI to show an error icon.
  The error message could be shown in a tooltip when hovering over the icon.

## Text Search

File list support by the `searchText` command.

- Currently, the `searchText` command only searches within a specified folder.
- Add support for searching within a list of files provided as input.
- This enables shrinking search results from a broader search to a more focused set of files.
- For example, first search a folder for "word1", then use the resulting file list to search for "word2".
- Specifically, first search for "Visible = ""on""", then search the results for "movegui".

Shrink search support in `TextSearchResultViewerApp`.

- The above shrink search feature should also be integrated into the `TextSearchResultViewerApp`.

_Copyright 2025 The MathWorks, Inc._
