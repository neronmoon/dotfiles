local h = require("helpers")

local editors = {
  { name = "Visual Studio Code", bundleIDs = { "com.microsoft.VSCode" } },
  { name = "IntelliJ IDEA",      bundleIDs = { "com.jetbrains.intellij" } },
  { name = "Cursor",             bundleIDs = { "com.todesktop.230313mzl4w4u92" } },
  -- osascript -e 'id of app "Cursor"'
}

hs.hotkey.bind({ "alt", "cmd", "shift" }, "M", function() -- Editor switching
  local i = (hs.settings.get("editor_idx") or 1) + 1
  if i > #editors then i = 1 end
  hs.settings.set("editor_idx", i)
  local e = editors[hs.settings.get("editor_idx") or 1]
  if e then hs.alert.show("Editor: " .. e.name, 0.6) end
end)

hs.hotkey.bind({ "alt" }, "S", function() -- Editor toggle
  local e = editors[hs.settings.get("editor_idx") or 1]
  if e then h.toggleApp(e) end
end)

h.mapKey({ "alt" }, "X", "Cursor", { "com.todesktop.230313mzl4w4u92" })
h.mapKey({ "alt" }, "P", "Bitwarden")
h.mapKey({ "alt" }, "E", "Telegram", { "ru.keepcoder.Telegram", "org.telegram.desktop" })
h.mapKey({ "alt" }, "A", "Vivaldi", { "com.vivaldi.Vivaldi" })
h.mapKey({ "alt" }, "D", "iTerm")
h.mapKey({ "alt" }, "T", "TiMe")
h.mapKey({ "alt" }, "N", "Obsidian")

-- remap caps lock to f13
os.execute("hidutil property --set '{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000039,\"HIDKeyboardModifierMappingDst\":0x700000068}]}'")
hs.hotkey.bind({}, "f13", function()
  local ABC = "com.apple.keylayout.ABC"
  local RUSSIAN = "com.apple.keylayout.Russian"
  local cur = hs.keycodes.currentSourceID()
  local nextID = (cur == ABC) and RUSSIAN or ABC
  hs.keycodes.currentSourceID(nextID)
end)

hs.hotkey.bind({ "cmd", "shift" }, "9", function()
  hs.osascript.applescript([[
tell application "System Settings"
  reveal pane id "com.apple.ControlCenter-Settings.extension"
end tell

delay 0.1

tell application "System Events"
    tell window 1 of application process "System Settings"
        tell pop up button "Automatically hide and show the menu bar" of group 9 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1
            set currentValue to value
            click
            if value = "In Full Screen Only" then
                click menu item "Always" of menu 1
                set newValue to "Always"
            else
                click menu item "In Full Screen Only" of menu 1
                set newValue to "In Full Screen Only"
            end if
            return newValue
        end tell
    end tell
end tell

delay 0.1

tell application "System Settings" to quit
  ]])
end)
