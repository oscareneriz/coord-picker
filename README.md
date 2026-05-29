# Coord Picker

A tiny always-on-top window that shows your **live mouse position in screen pixels** and copies `x, y` to the clipboard — so you can point me (Claude) at an exact spot on your screen and just paste the numbers.

## Run it

Double-click **`Run Coordinate Picker.cmd`**.

(Or run `coord-picker.ps1` directly: right-click → Run with PowerShell.)

## Use it

1. A small cream window appears in the top-left, always on top, showing the live cursor coordinate.
2. **Move your mouse** to the exact spot you want — anywhere on screen: a webpage, SolidWorks, any app.
3. Press **SPACE** (or F8 / Enter) to copy that `x, y` to your clipboard. The window confirms "Copied: …".
4. Paste it to me. Repeat for as many points as you need.
5. Press **Esc** to quit.

> Keep the little window focused (don't click into other apps). Moving the mouse doesn't change keyboard focus, so you can hover over anything and still press SPACE. If you *do* click elsewhere, just click the Coord Picker window once to refocus it.

## Notes

- Coordinates are **true physical pixels** (the script sets the process DPI-aware), so they match what you'd measure in a screenshot even if Windows display scaling is on.
- On multi-monitor setups, `x` can be negative for monitors to the left of your main one — that's normal (virtual-screen coordinates).
- These are **screen** pixels. For positioning things *inside* a web page or the Claude Inline Edit popup, screen pixels don't map cleanly (browser chrome, scroll, zoom) — for the popup, use its built-in drag + 📌 pin instead.
