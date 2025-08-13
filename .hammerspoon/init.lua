local h = require("helpers")

local editors = {
  { name = "Visual Studio Code", bundleIDs = { "com.microsoft.VSCode" } },
  { name = "IntelliJ IDEA", bundleIDs = { "com.jetbrains.intellij" } },
  { name = "Cursor", bundleIDs = { "com.todesktop.230313mzl4w4u92" } },
  -- osascript -e 'id of app "Cursor"'
}

hs.hotkey.bind({"alt","cmd","shift"}, "M", function() -- Editor switching
  local i = (hs.settings.get("editor_idx") or 1) + 1
  if i > #editors then i = 1 end
  hs.settings.set("editor_idx", i)
  local e = editors[hs.settings.get("editor_idx") or 1]
  if e then hs.alert.show("Editor: " .. e.name, 0.6) end
end)

hs.hotkey.bind({"alt"}, "S", function() -- Editor toggle
  local e = editors[hs.settings.get("editor_idx") or 1]
  if e then h.toggleApp(e) end
end)

h.mapKey({"alt"}, "X", "Visual Studio Code", { "com.microsoft.VSCode" })
h.mapKey({"alt"}, "P", "Bitwarden")
h.mapKey({"alt"}, "E", "Telegram", { "ru.keepcoder.Telegram", "org.telegram.desktop" })
h.mapKey({"alt"}, "A", "Vivaldi", { "com.vivaldi.Vivaldi" })
h.mapKey({"alt"}, "D", "iTerm", { "com.googlecode.iterm2" })
h.mapKey({"alt"}, "T", "TiMe")
h.mapKey({"alt"}, "N", "Obsidian")
