local function toggleApp(spec)
  local app = nil
  if spec.bundleIDs then
    for _, bid in ipairs(spec.bundleIDs) do
      app = hs.application.get(bid)
      if app then break end
    end
  end
  if not app and spec.name then app = hs.application.get(spec.name) end

  local function launch()
    if spec.bundleIDs then
      for _, bid in ipairs(spec.bundleIDs) do
        if hs.application.launchOrFocusByBundleID(bid) then return end
      end
    end
    if spec.name then hs.application.launchOrFocus(spec.name) end
  end

  if app then
    if app:isFrontmost() then app:hide() else app:unhide(); app:activate() end
  else
    launch()
  end
end


local function mapKey(mods, key, name, bids)
  hs.hotkey.bind(mods, key, function()
    toggleApp({ name = name, bundleIDs = bids })
  end)
end

-- export functions
return {
  toggleApp = toggleApp,
  mapKey = mapKey,
}
