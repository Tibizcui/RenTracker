--[[============================================================================
  RenTracker - Intégration TibiSuite "Midnight"  (ajout non destructif)
============================================================================]]

local FRAME    = "RNTMainFrame"
local ACCENT   = { 0.867, 0.651, 0.412 }   -- or/sable (logo #DDA669)
local LOGO     = "Interface\\AddOns\\RenTracker\\medias\\RenTracker"
local KEY      = "Rep"
local FULLSKIN = false

local function GetUI() return _G.TibiMidnight end
local function OptGet(k) return _G.RenTrackerDB and _G.RenTrackerDB.options and _G.RenTrackerDB.options[k] end
local function OptSet(k, v)
  if _G.RenTrackerDB then _G.RenTrackerDB.options = _G.RenTrackerDB.options or {}; _G.RenTrackerDB.options[k] = v end
end

-- ---------------------------------------------------------------- Options
local panel
local function BuildOptions()
  local ui = GetUI(); if not ui then return nil end
  if panel then return panel end
  panel = ui.CreateOptionsPanel({
    name = "RenTrackerOptionsMidnight",
    title = "|cFF9480FFRenTracker|r  Options", accent = ACCENT })

  panel:Section("Fenêtre")
  panel:Button("Ouvrir / fermer", function()
    if _G.RenTracker_Toggle then _G.RenTracker_Toggle() end
  end)
  panel:Button("Recentrer la fenêtre", function()
    local f = _G[FRAME]; if f then f:ClearAllPoints(); f:SetPoint("CENTER") end
  end)

  panel:Section("Comportement")
  panel:Check("Suivi auto de la réputation par zone",
    function() return OptGet("autoTrack") end, function(v) OptSet("autoTrack", v) end)
  panel:Check("Message de bienvenue au login",
    function() return OptGet("loginMsg") end, function(v) OptSet("loginMsg", v) end)
  panel:Check("Son de notification",
    function() return OptGet("sound") end, function(v) OptSet("sound", v) end)

  panel:Note("Astuce : clic droit sur la vignette Réput. dans la barre TibiSuite ouvre aussi ces options.")
  return panel
end

function RenTracker_OpenOptions()
  local p = BuildOptions(); if p then p:Toggle() end
end

-- ---------------------------------------------------------------- Recherche
local function provider(q)
  local out, ui = {}, GetUI()
  local data = _G.RenTrackerData
  if not ui or type(data) ~= "table" then return out end
  local function open()
    local f = _G[FRAME]
    if _G.RenTracker_Toggle and (not f or not f:IsShown()) then _G.RenTracker_Toggle() end
  end
  local function add(text) out[#out + 1] = { text = text, onClick = open } end
  for extKey, ext in pairs(data) do
    if type(ext) == "table" and ext.factions then
      for _, fac in ipairs(ext.factions) do
        local fname = fac.name or "?"
        -- Faction (nom + zone + agent de quête)
        local fhay = (fac.name or "") .. " " .. (fac.zone or "") .. " " .. (fac.qm_name or "")
        if ui.Match(fhay, q) then
          add(fname .. "  |cff808080" .. tostring(extKey) .. "|r")
        end
        -- Quêtes de la faction (faites ou non : hebdo, uniques, quotidiennes)
        if type(fac.quests) == "table" then
          for _, qu in ipairs(fac.quests) do
            local qhay = (qu.name or "") .. " " .. (qu.npc or "") .. " " .. (qu.zone or "")
            if ui.Match(qhay, q) then
              add((qu.name or "quête") .. "  |cff808080" .. fname .. "|r")
            end
          end
        end
        if #out >= 80 then return out end
      end
    end
  end
  return out
end

local searchPopup
local function OpenSearch()
  local ui = GetUI(); if not ui then return end
  if not searchPopup then
    searchPopup = ui.CreateSearchPopup({
      name = "RenTrackerSearchPopup",
      title = "|cFF9480FFRenTracker|r  Recherche", accent = ACCENT, logo = LOGO, provider = provider })
  end
  searchPopup.Toggle()
end

-- ---------------------------------------------------------- Attache & skin
local function Decorate()
  local ui = GetUI(); local f = _G[FRAME]
  if not (ui and f) then return end
  if not f._tibiSkinned then
    ui.SkinFrame(f, ACCENT)
    f._tibiSkinned = true
  end
  if f._tibiControls then return end
  ui.AddHeaderControls(f, {
    accent = ACCENT,
    onOptions = function() RenTracker_OpenOptions() end,
    provider = provider,
  })
end

-- Inscription immediate au registre de recherche globale
-- (le provider lit les donnees a la volee ; plus fiable que PLAYER_LOGIN seul)
do local _u = GetUI(); if _u and _u.RegisterSearch then _u.RegisterSearch(KEY, "Réput.", provider) end end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function()
  local ui = GetUI()
  if ui and ui.RegisterSearch then ui.RegisterSearch(KEY, "Réput.", provider) end
  C_Timer.After(1.0, Decorate)
  C_Timer.After(3.0, Decorate)
end)
