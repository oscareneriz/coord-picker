# Install guide for Claude Code

You are helping someone set up **Coord Picker**, a tiny Windows tool. Be friendly and concise.

## 1. Pre-flight
- This is **Windows-only** (it uses .NET WinForms via PowerShell). If the user is on macOS/Linux, tell them it won't run and stop.

## 2. Get the files
- If you're already in the cloned/downloaded repo folder, use it.
- Otherwise: `gh repo clone oscareneriz/coord-picker` (or have them download + unzip the ZIP).

## 3. Run it
- Tell the user to double-click **`Run Coordinate Picker.cmd`**.
- Or run directly: `powershell -NoProfile -ExecutionPolicy Bypass -STA -File coord-picker.ps1`.
- No install, no dependencies, nothing to build.

## 4. How to use it
Explain:
1. A small always-on-top window shows the live cursor X,Y.
2. Move the mouse to the target spot (any app), press **SPACE** (or F8/Enter) to copy `x, y` to the clipboard.
3. Paste those numbers back to Claude. **Esc** quits.
4. Keep that little window focused so it hears the key — moving the mouse doesn't change keyboard focus.

Don't commit or push anything.
