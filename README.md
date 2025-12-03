📌 Description

This SwiftUI application is a simple JSON learning and debugging tool.
Its purpose is to help beginners understand how JSON parsing works in Swift by providing a clean interface where you can:

✔ Enter raw JSON

The user types JSON text into a multiline input field.

✔ Automatically clean invalid quotes

The app replaces incorrect quotation marks (such as “ ” « » ‘ ’) with standard ASCII quotes " to prevent parsing errors.

✔ Decode JSON

When pressing Run, the app attempts to parse the JSON using JSONSerialization.
If successful, it displays the JSON key–value pairs in a readable multiline format.

✔ See parsing errors

If the JSON contains invalid syntax, the app shows an error message (“JSON syntax”).

✔ JSON example hint

Users can toggle a built-in example JSON snippet to understand the correct structure.

✔ Dark/Light Mode support

The interface adapts automatically to the system's color scheme.

✔ Clear button

Resets all fields and output.

🧩 Main Features

SwiftUI-based interface

JSON preprocessing (fixes problematic quotation marks)

JSON parsing using JSONSerialization

Clean output formatting

Example JSON toggle

Responsive layout

Adaptive color scheme

Beginner-friendly structure
