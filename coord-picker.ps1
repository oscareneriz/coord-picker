# ============================================================================
# Coord Picker — a tiny always-on-top window that shows the live mouse position
# in screen pixels and copies "x, y" to the clipboard so you can paste it to me.
#
# Use: launch it, move the mouse to the spot you want, press SPACE (or F8/Enter)
# to copy the coordinate. Esc quits. Keep this little window focused so it can
# hear the key — moving the mouse doesn't change keyboard focus, so you can hover
# anywhere (another app, a CAD window, etc.) and still press SPACE.
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Report TRUE physical pixels regardless of Windows display scaling.
try {
  Add-Type -Namespace Native -Name DPI -MemberDefinition `
    '[DllImport("user32.dll")] public static extern bool SetProcessDPIAware();'
  [Native.DPI]::SetProcessDPIAware() | Out-Null
} catch {}

# 60s pastel palette
$BG  = [System.Drawing.ColorTranslator]::FromHtml('#f5edde')
$FG  = [System.Drawing.ColorTranslator]::FromHtml('#2a1c0c')
$FG2 = [System.Drawing.ColorTranslator]::FromHtml('#7a5c38')
$GRN = [System.Drawing.ColorTranslator]::FromHtml('#5ca870')

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Coord Picker'
$form.FormBorderStyle = 'FixedToolWindow'
$form.TopMost = $true
$form.StartPosition = 'Manual'
$form.Location = New-Object System.Drawing.Point(40, 40)
$form.ClientSize = New-Object System.Drawing.Size(270, 132)
$form.BackColor = $BG
$form.KeyPreview = $true
$form.Font = New-Object System.Drawing.Font('Segoe UI', 9)

# Big live coordinate readout
$coord = New-Object System.Windows.Forms.Label
$coord.SetBounds(0, 10, 270, 46)
$coord.TextAlign = 'MiddleCenter'
$coord.Font = New-Object System.Drawing.Font('Consolas', 22, [System.Drawing.FontStyle]::Bold)
$coord.ForeColor = $FG
$coord.Text = '0, 0'
$form.Controls.Add($coord)

# "Copied: ..." confirmation line
$copied = New-Object System.Windows.Forms.Label
$copied.SetBounds(0, 60, 270, 22)
$copied.TextAlign = 'MiddleCenter'
$copied.ForeColor = $GRN
$copied.Text = ''
$form.Controls.Add($copied)

# Instructions
$hint = New-Object System.Windows.Forms.Label
$hint.SetBounds(8, 86, 254, 42)
$hint.TextAlign = 'MiddleCenter'
$hint.ForeColor = $FG2
$hint.Text = "Hover the target, press SPACE to copy x,y." + [Environment]::NewLine +
             "Esc to quit  •  keep this window focused."
$form.Controls.Add($hint)

# Live update of the cursor position
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 25
$timer.Add_Tick({
  $p = [System.Windows.Forms.Cursor]::Position
  $coord.Text = "$($p.X), $($p.Y)"
})

$capture = {
  $p = [System.Windows.Forms.Cursor]::Position
  $txt = "$($p.X), $($p.Y)"
  try { [System.Windows.Forms.Clipboard]::SetText($txt) } catch {}
  $copied.Text = "Copied: $txt"
}

$form.Add_KeyDown({
  param($s, $e)
  if ($e.KeyCode -eq 'Escape') {
    $form.Close()
  } elseif ($e.KeyCode -eq 'Space' -or $e.KeyCode -eq 'F8' -or $e.KeyCode -eq 'Enter') {
    & $capture
    $e.SuppressKeyPress = $true   # no beep, no scroll
  }
})

$form.Add_Shown({ $timer.Start() })
$form.Add_FormClosed({ $timer.Stop(); $timer.Dispose() })

[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($form)
