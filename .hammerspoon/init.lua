local h = require("helpers")

local editors = {
  { name = "Visual Studio Code", bundleIDs = { "com.microsoft.VSCode" } },
  { name = "IntelliJ IDEA",    bundleIDs = { "com.jetbrains.intellij" } },
  { name = "Cursor",    bundleIDs = { "com.todesktop.230313mzl4w4u92" } },
  -- osascript -e 'id of app "Cursor"'
}

local function getIdx() return hs.settings.get("editor_idx") or 1 end
local function setIdx(i) hs.settings.set("editor_idx", i) end
local function currentEditor() return editors[getIdx()] end

local function showCurrent()
  local e = currentEditor()
  if e then hs.alert.show("Editor: " .. e.name, 0.6) end
end

hs.hotkey.bind({"alt","cmd","shift"}, "M", function()
  local i = getIdx() + 1
  if i > #editors then i = 1 end
  setIdx(i)
  showCurrent()
end)

hs.hotkey.bind({"alt"}, "S", function()
  local e = currentEditor()
  if e then h.toggleApp(e) end
end)


h.mapKey({"alt"}, "X", "Visual Studio Code", { "com.microsoft.VSCode" })
h.mapKey({"alt"}, "P", "Bitwarden")
h.mapKey({"alt"}, "E", "Telegram", { "ru.keepcoder.Telegram", "org.telegram.desktop" })
h.mapKey({"alt"}, "A", "Vivaldi", { "com.vivaldi.Vivaldi" })
h.mapKey({"alt"}, "D", "iTerm", { "com.googlecode.iterm2" })
h.mapKey({"alt"}, "T", "TiMe")
h.mapKey({"alt"}, "N", "Obsidian")
