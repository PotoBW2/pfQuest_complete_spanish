-- multi api compat
local compat = pfQuestCompat
local L = pfQuest_Loc

pfQuest_history = {}
pfQuest_colors = {}
pfQuest_config = {}

local reset = {
  config = function()
    local dialog = StaticPopupDialogs["PFQUEST_RESET"]
    dialog.text = L["¿Realmente quieres restablecer la configuración?"]
    dialog.OnAccept = function()
      pfQuest_config = nil
      ReloadUI()
    end

    StaticPopup_Show("PFQUEST_RESET")
  end,
  history = function()
    local dialog = StaticPopupDialogs["PFQUEST_RESET"]
    dialog.text = L["¿Realmente quieres restablecer el historial de misiones?"]
    dialog.OnAccept = function()
      pfQuest_history = nil
      ReloadUI()
    end

    StaticPopup_Show("PFQUEST_RESET")
  end,
  cache = function()
    local dialog = StaticPopupDialogs["PFQUEST_RESET"]
    dialog.text = L["¿Realmente quieres restablecer los cachés?"]
    dialog.OnAccept = function()
      pfQuest_questcache = nil
      ReloadUI()
    end

    StaticPopup_Show("PFQUEST_RESET")
  end,
  everything = function()
    local dialog = StaticPopupDialogs["PFQUEST_RESET"]
    dialog.text = L["¿Realmente quieres restablecer todo?"]
    dialog.OnAccept = function()
      pfQuest_config, pfBrowser_fav, pfQuest_history, pfQuest_colors, pfQuest_server = nil
      ReloadUI()
    end

    StaticPopup_Show("PFQUEST_RESET")
  end,
}

-- default config
pfQuest_defconfig = {
  { -- 1: All Quests; 2: Tracked; 3: Manual; 4: Hide
    config = "trackingmethod",
    text = nil, default = 1, type = nil
  },

  { text = L["General"],
    default = nil, type = "header" },
  { text = L["Habilitar el menú en el mapa del mundo"],
    default = "1", type = "checkbox", config = "worldmapmenu" },
  { text = L["Habilitar el botón del minimapa"],
    default = "1", type = "checkbox", config = "minimapbutton" },
  { text = L["Habilitar el Rastreador de Misiones"],
    default = "1", type = "checkbox", config = "showtracker" },
  { text = L["Habilitar botones del registro de misiones"],
    default = "1", type = "checkbox", config = "questlogbuttons" },
  { text = L["Habilitar la compatibilidad con el Enlace de Búsqueda"],
    default = "1", type = "checkbox", config = "questlinks" },
  { text = L["Mostrar los IDs de la Base de Datos"],
    default = "0", type = "checkbox", config = "showids" },
  { text = L["Sorteo de favoritos al iniciar sesión"],
    default = "0", type = "checkbox", config = "favonlogin" },
  { text = L["Probabilidad mínima de caída de objetos"],
    default = "1", type = "text", config = "mindropchance" },
  { text = L["Mostrar información sobre herramientas"],
    default = "1", type = "checkbox", config = "showtooltips" },
  { text = L["Mostrar ayuda en las descripciones emergentes"],
    default = "1", type = "checkbox", config = "tooltiphelp" },
  { text = L["Mostrar nivel en el Rastreador de Misiones"],
    default = "1", type = "checkbox", config = "trackerlevel" },
  { text = L["Mostrar nivel en el Registro de Misiones"],
    default = "0", type = "checkbox", config = "questloglevel" },

  { text = L["Misiones"],
    default = nil, type = "header" },
  { text = L["Visibilidad del Rastreador de Misiones"],
    default = "0", type = "text", config = "trackeralpha" },
  { text = L["Tamaño de fuente en el Rastreador de Misiones"],
    default = "12", type = "text", config = "trackerfontsize", },
  { text = L["Desplegar objetivos del Rastreador de Misiones "],
    default = "0", type = "checkbox", config = "trackerexpand" },
  { text = L["Puntos de aparición de objetivos de la misión (mapa del mundo)"],
    default = "1", type = "checkbox", config = "showspawn" },
  { text = L["Puntos de aparición de objetivos de la misión (minimapa)"],
    default = "1", type = "checkbox", config = "showspawnmini" },
  { text = L["Iconos de objetivos de misiones (mapa del mundo)"],
    default = "1", type = "checkbox", config = "showcluster" },
  { text = L["Iconos de objetivos de la misión (minimapa)"],
    default = "0", type = "checkbox", config = "showclustermini" },
  { text = L["Mostrar los otorgantes de misiones disponibles"],
    default = "1", type = "checkbox", config = "allquestgivers" },
  { text = L["Mostrar los otorgantes de misiones actuales"],
    default = "1", type = "checkbox", config = "currentquestgivers" },
  { text = L["Mostrar los otorgantes de misiones de bajo nivel"],
    default = "0", type = "checkbox", config = "showlowlevel" },
  { text = L["Mostrar otorgantes de misiones de nivel +3"],
    default = "0", type = "checkbox", config = "showhighlevel" },
  { text = L["Mostrar eventos y misiones diarias"],
    default = "0", type = "checkbox", config = "showfestival" },

  { text = L["Mapa y minimapa"],
    default = nil, type = "header" },
  { text = L["Habilitar nodos del minimapa"],
    default = "1", type = "checkbox", config = "minimapnodes" },
  { text = L["Usar iconos agrupados monocromáticos"],
    default = "0", type = "checkbox", config = "clustermono" },
  { text = L["Usar  los iconos de nodo del minimapa recortados"],
    default = "1", type = "checkbox", config = "cutoutminimap" },
  { text = L["Usar  los iconos de nodos del mapa del mundo recortados"],
    default = "0", type = "checkbox", config = "cutoutworldmap" },
  { text = L["Color Map Nodes By Spawn"],
    default = "0", type = "checkbox", config = "spawncolors" },
  { text = L["Transparencia de nodos en el mapa del mundo"],
    default = "1.0", type = "text", config = "worldmaptransp" },
  { text = L["Transparencia de nodos del minimapa"],
    default = "1.0", type = "text", config = "minimaptransp" },
  { text = L["Transparencia de desvanecimiento de nodos"],
    default = "0.3", type = "text", config = "nodefade" },
  { text = L["Resaltar nodos al pasar el ratón por encima"],
    default = "1", type = "checkbox", config = "mouseover" },

  { text = L["Rutas"],
    default = nil, type = "header" },
  { text = L["Mostrar ruta entre objetos"],
    default = "1", type = "checkbox", config = "routes" },
  { text = L["Incluir ubicaciones de misiones unificadas"],
    default = "1", type = "checkbox", config = "routecluster" },
  { text = L["Incluir finalizadores de misiones"],
    default = "1", type = "checkbox", config = "routeender" },
  { text = L["Incluir iniciadores de misiones"],
    default = "0", type = "checkbox", config = "routestarter" },
  { text = L["Mostrar ruta en el minimapa"],
    default = "0", type = "checkbox", config = "routeminimap" },
  { text = L["Mostrar flechas a lo largo de las rutas"],
    default = "1", type = "checkbox", config = "arrow" },

  { text = L["Datos del usuario"],
    default = nil, type = "header" },
  { text = L["Restablecer configuración"],
    default = "1", type = "button", func = reset.config },
  { text = L["Restablecer historial de misiones"],
    default = "1", type = "button", func = reset.history },
  { text = L["Restablecer caché"],
    default = "1", type = "button", func = reset.cache },
  { text = L["Restablecer todo"],
    default = "1", type = "button", func = reset.everything },
}

StaticPopupDialogs["PFQUEST_RESET"] = {
  button1 = YES,
  button2 = NO,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1,
}

pfQuestConfig = CreateFrame("Frame", "pfQuestConfig", UIParent)
pfQuestConfig:Hide()
pfQuestConfig:SetWidth(280)
pfQuestConfig:SetHeight(550)
pfQuestConfig:SetPoint("CENTER", 0, 0)
pfQuestConfig:SetFrameStrata("HIGH")
pfQuestConfig:SetMovable(true)
pfQuestConfig:EnableMouse(true)
pfQuestConfig:SetClampedToScreen(true)
pfQuestConfig:RegisterEvent("ADDON_LOADED")
pfQuestConfig:SetScript("OnEvent", function()
  if arg1 == "pfQuest" or arg1 == "pfQuest-tbc" or arg1 == "pfQuest-wotlk" then
    pfQuestConfig:LoadConfig()
    pfQuestConfig:MigrateHistory()
    pfQuestConfig:CreateConfigEntries(pfQuest_defconfig)

    pfQuest_questcache = pfQuest_questcache or {}
    pfQuest_history = pfQuest_history or {}
    pfQuest_colors = pfQuest_colors or {}
    pfQuest_config = pfQuest_config or {}
    pfBrowser_fav = pfBrowser_fav or {["units"] = {}, ["objects"] = {}, ["items"] = {}, ["quests"] = {}}

    -- clear quest history on new characters
    if UnitXP("player") == 0 and UnitLevel("player") == 1 then
      pfQuest_history = {}
    end

    if pfBrowserIcon and pfQuest_config["minimapbutton"] == "0" then
      pfBrowserIcon:Hide()
    end
  end
end)

pfQuestConfig:SetScript("OnMouseDown", function()
  this:StartMoving()
end)

pfQuestConfig:SetScript("OnMouseUp", function()
  this:StopMovingOrSizing()
end)

pfQuestConfig:SetScript("OnShow", function()
  this:UpdateConfigEntries()
end)

pfQuestConfig.vpos = 40

pfUI.api.CreateBackdrop(pfQuestConfig, nil, true, 0.75)
table.insert(UISpecialFrames, "pfQuestConfig")

-- detect current addon path
local tocs = { "", "-master", "-tbc", "-wotlk" }
for _, name in pairs(tocs) do
  local current = string.format("pfQuest%s", name)
  local _, title = GetAddOnInfo(current)
  if title then
    pfQuestConfig.path = "Interface\\AddOns\\" .. current
    pfQuestConfig.version = tostring(GetAddOnMetadata(current, "Version"))
    break
  end
end

pfQuestConfig.title = pfQuestConfig:CreateFontString("Status", "LOW", "GameFontNormal")
pfQuestConfig.title:SetFontObject(GameFontWhite)
pfQuestConfig.title:SetPoint("TOP", pfQuestConfig, "TOP", 0, -8)
pfQuestConfig.title:SetJustifyH("LEFT")
pfQuestConfig.title:SetFont(pfUI.font_default, 14)
pfQuestConfig.title:SetText("|cff33ffccpf|rQuest " .. L["Config"])

pfQuestConfig.close = CreateFrame("Button", "pfQuestConfigClose", pfQuestConfig)
pfQuestConfig.close:SetPoint("TOPRIGHT", -5, -5)
pfQuestConfig.close:SetHeight(20)
pfQuestConfig.close:SetWidth(20)
pfQuestConfig.close.texture = pfQuestConfig.close:CreateTexture("pfQuestionDialogCloseTex")
pfQuestConfig.close.texture:SetTexture(pfQuestConfig.path.."\\compat\\close")
pfQuestConfig.close.texture:ClearAllPoints()
pfQuestConfig.close.texture:SetPoint("TOPLEFT", pfQuestConfig.close, "TOPLEFT", 4, -4)
pfQuestConfig.close.texture:SetPoint("BOTTOMRIGHT", pfQuestConfig.close, "BOTTOMRIGHT", -4, 4)

pfQuestConfig.close.texture:SetVertexColor(1,.25,.25,1)
pfUI.api.SkinButton(pfQuestConfig.close, 1, .5, .5)
pfQuestConfig.close:SetScript("OnClick", function()
  this:GetParent():Hide()
end)

pfQuestConfig.save = CreateFrame("Button", "pfQuestConfigReload", pfQuestConfig)
pfQuestConfig.save:SetWidth(160)
pfQuestConfig.save:SetHeight(28)
pfQuestConfig.save:SetPoint("BOTTOM", 0, 10)
pfQuestConfig.save:SetScript("OnClick", ReloadUI)
pfQuestConfig.save.text = pfQuestConfig.save:CreateFontString("Caption", "LOW", "GameFontWhite")
pfQuestConfig.save.text:SetAllPoints(pfQuestConfig.save)
pfQuestConfig.save.text:SetFont(pfUI.font_default, pfUI_config.global.font_size, "OUTLINE")
pfQuestConfig.save.text:SetText(L["Close & Reload"])
pfUI.api.SkinButton(pfQuestConfig.save)

function pfQuestConfig:LoadConfig()
  if not pfQuest_config then pfQuest_config = {} end
  for id, data in pairs(pfQuest_defconfig) do
    if data.config and not pfQuest_config[data.config] then
      pfQuest_config[data.config] = data.default
    end
  end
end

function pfQuestConfig:MigrateHistory()
  if not pfQuest_history then return end

  local match = false

  for entry, data in pairs(pfQuest_history) do
    if type(entry) == "string" then
      for id in pairs(pfDatabase:GetIDByName(entry, "quests")) do
        pfQuest_history[id] = { 0, 0 }
        pfQuest_history[entry] = nil
        match = true
      end
    elseif data == true then
      pfQuest_history[entry] = { 0, 0 }
    elseif type(data) == "table" and not data[1] then
      pfQuest_history[entry] = { 0, 0 }
    end
  end

  if match == true then
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ffccpf|cffffffffQuest|r: " .. L["Quest history migration completed."])
  end
end

local maxh, maxw = 0, 0
local width, height = 230, 22
local maxtext = 130
local configframes = {}
function pfQuestConfig:CreateConfigEntries(config)
  local count = 1

  for _, data in pairs(config) do
    if data.type then
      -- basic frame
      local frame = CreateFrame("Frame", "pfQuestConfig" .. count, pfQuestConfig)
      configframes[data.text] = frame

      -- caption
      frame.caption = frame:CreateFontString("Status", "LOW", "GameFontWhite")
      frame.caption:SetFont(pfUI.font_default, pfUI_config.global.font_size, "OUTLINE")
      frame.caption:SetPoint("LEFT", 20, 0)
      frame.caption:SetJustifyH("LEFT")
      frame.caption:SetText(data.text)
      maxtext = max(maxtext, frame.caption:GetStringWidth())

      -- header
      if data.type == "header" then
        frame.caption:SetPoint("LEFT", 10, 0)
        frame.caption:SetTextColor(.3,1,.8)
        frame.caption:SetFont(pfUI.font_default, pfUI_config.global.font_size+2, "OUTLINE")

      -- checkbox
      elseif data.type == "checkbox" then
        frame.input = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
        frame.input:SetNormalTexture("")
        frame.input:SetPushedTexture("")
        frame.input:SetHighlightTexture("")
        pfUI.api.CreateBackdrop(frame.input, nil, true)

        frame.input:SetWidth(16)
        frame.input:SetHeight(16)
        frame.input:SetPoint("RIGHT" , -20, 0)

        frame.input.config = data.config
        if pfQuest_config[data.config] == "1" then
          frame.input:SetChecked()
        end

        frame.input:SetScript("OnClick", function ()
          if this:GetChecked() then
            pfQuest_config[this.config] = "1"
          else
            pfQuest_config[this.config] = "0"
          end

          pfQuest:ResetAll()
        end)
      elseif data.type == "text" then
        -- input field
        frame.input = CreateFrame("EditBox", nil, frame)
        frame.input:SetTextColor(.2,1,.8,1)
        frame.input:SetJustifyH("RIGHT")
        frame.input:SetTextInsets(5,5,5,5)
        frame.input:SetWidth(32)
        frame.input:SetHeight(16)
        frame.input:SetPoint("RIGHT", -20, 0)
        frame.input:SetFontObject(GameFontNormal)
        frame.input:SetAutoFocus(false)
        frame.input:SetScript("OnEscapePressed", function(self)
          this:ClearFocus()
        end)

        frame.input.config = data.config
        frame.input:SetText(pfQuest_config[data.config])

        frame.input:SetScript("OnTextChanged", function(self)
          pfQuest_config[this.config] = this:GetText()
        end)

        pfUI.api.CreateBackdrop(frame.input, nil, true)
      elseif data.type == "button" and data.func then
        frame.input = CreateFrame("Button", nil, frame)
        frame.input:SetWidth(32)
        frame.input:SetHeight(16)
        frame.input:SetPoint("RIGHT", -20, 0)
        frame.input:SetScript("OnClick", data.func)
        frame.input.text = frame.input:CreateFontString("Caption", "LOW", "GameFontWhite")
        frame.input.text:SetAllPoints(frame.input)
        frame.input.text:SetFont(pfUI.font_default, pfUI_config.global.font_size, "OUTLINE")
        frame.input.text:SetText("OK")
        pfUI.api.SkinButton(frame.input)
      end

      -- increase size and zoom back due to blizzard backdrop reasons...
      if frame.input and pfUI.api.emulated then
        frame.input:SetWidth(frame.input:GetWidth()/.6)
        frame.input:SetHeight(frame.input:GetHeight()/.6)
        frame.input:SetScale(.8)
        if frame.input.SetTextInsets then
          frame.input:SetTextInsets(8,8,8,8)
        end
      end

      count = count + 1
    end
  end

  -- update sizes / positions
  width = maxtext + 100
  local column, row = 1, 0

  for _, data in pairs(config) do
    if data.type then
      -- empty line for headers, next column for > 20 entries
      row = row + ( data.type == "header" and row > 1 and 2 or 1 )
      if row > 20 and data.type == "header" then
        column, row = column + 1, 1
      end

      -- update max size values
      maxw, maxh = max(maxw, column), max(maxh, row)

      -- align frames to sizings
      local spacer = (column-1)*20
      local x, y = (column-1)*width, -(row-1)*height
      local frame = configframes[data.text]
      frame:SetWidth(width)
      frame:SetHeight(height)
      frame:SetPoint("TOPLEFT", pfQuestConfig, "TOPLEFT", x + spacer + 10, y - 40)
    end
  end

  local spacer = (maxw-1)*20
  pfQuestConfig:SetWidth(maxw*width + spacer + 20)
  pfQuestConfig:SetHeight(maxh*height + 100)
end

function pfQuestConfig:UpdateConfigEntries()
  for _, data in pairs(pfQuest_defconfig) do
    if data.type and configframes[data.text] then
      if data.type == "checkbox" then
        configframes[data.text].input:SetChecked((pfQuest_config[data.config] == "1" and true or nil))
      elseif data.type == "text" then
        configframes[data.text].input:SetText(pfQuest_config[data.config])
      end
    end
  end
end

do -- welcome/init popup dialog
  local config_stage = {
    arrow = 1,
    mode = 2
  }

  -- create welcome/init window
  pfQuestInit = CreateFrame("Frame", "pfQuestInit", UIParent)
  pfQuestInit:Hide()
  pfQuestInit:SetWidth(400)
  pfQuestInit:SetHeight(270)
  pfQuestInit:SetPoint("CENTER", 0, 0)
  pfQuestInit:RegisterEvent("PLAYER_ENTERING_WORLD")
  pfQuestInit:SetScript("OnEvent", function()
    if pfQuest_config.welcome ~= "1" then
      -- parse current config
      if pfQuest_config["showspawn"] == "0" and pfQuest_config["showcluster"] == "1" then
        config_stage.mode = 1
      elseif pfQuest_config["showspawn"] == "1" and pfQuest_config["showcluster"] == "0" then
        config_stage.mode = 3
      end

      if pfQuest_config["arrow"] == "0" then
        config_stage.arrow = nil
      end

      -- reload ui elements
      pfQuestInit[1].bg:SetDesaturated(true)
      pfQuestInit[2].bg:SetDesaturated(true)
      pfQuestInit[3].bg:SetDesaturated(true)
      pfQuestInit[config_stage.mode].bg:SetDesaturated(false)
      pfQuestInit.checkbox:SetChecked(config_stage.arrow)

      pfQuestInit:Show()
    end
    this:UnregisterAllEvents()
  end)

  pfUI.api.CreateBackdrop(pfQuestInit, nil, true, 0.85)

  -- welcome title
  pfQuestInit.title = pfQuestInit:CreateFontString("Status", "LOW", "GameFontWhite")
  pfQuestInit.title:SetPoint("TOP", pfQuestInit, "TOP", 0, -17)
  pfQuestInit.title:SetJustifyH("LEFT")
  pfQuestInit.title:SetText(L["Por favor seleccione su preferida |cff33ffccpf|cffffffffQuest|r modo:"])

  -- questing mode
  local buttons = {
    { caption = L["Simple Markers"], texture = "\\img\\init\\simple", position = { "TOPLEFT", 10, -40 },
      tooltip = L["Only show cluster icons with summarized objective locations based on spawn points"] },
    { caption = L["Combined"], texture = "\\img\\init\\combined", position = { "TOP", 0, -40 },
      tooltip = L["Show cluster icons with summarized locations and also display all spawn points of each quest objective"] },
    { caption = L["Spawn Points"], texture = "\\img\\init\\spawns", position = { "TOPRIGHT", -10, -40 },
      tooltip = L["Display all spawn points of each quest objective and hide summarized cluster icons."] },
  }

  for i, button in pairs(buttons) do
    pfQuestInit[i] = CreateFrame("Button", "pfQuestInitLeft", pfQuestInit)
    pfQuestInit[i]:SetWidth(120)
    pfQuestInit[i]:SetHeight(160)
    pfQuestInit[i]:SetPoint(unpack(button.position))
    pfQuestInit[i]:SetID(i)

    pfQuestInit[i].bg = pfQuestInit[i]:CreateTexture(nil, "NORMAL")
    pfQuestInit[i].bg:SetWidth(200)
    pfQuestInit[i].bg:SetHeight(200)
    pfQuestInit[i].bg:SetPoint("CENTER", 0, 0)
    pfQuestInit[i].bg:SetTexture(pfQuestConfig.path..button.texture)

    pfQuestInit[i].caption = pfQuestInit:CreateFontString("Status", "LOW", "GameFontWhite")
    pfQuestInit[i].caption:SetPoint("TOP", pfQuestInit[i], "BOTTOM", 0, -5)
    pfQuestInit[i].caption:SetJustifyH("LEFT")
    pfQuestInit[i].caption:SetText(button.caption)

    pfUI.api.SkinButton(pfQuestInit[i])

    pfQuestInit[i]:SetScript("OnClick", function()
      pfQuestInit[1].bg:SetDesaturated(true)
      pfQuestInit[2].bg:SetDesaturated(true)
      pfQuestInit[3].bg:SetDesaturated(true)
      pfQuestInit[this:GetID()].bg:SetDesaturated(false)

      config_stage.mode = this:GetID()
    end)

    local OnEnter = pfQuestInit[i]:GetScript("OnEnter")
    pfQuestInit[i]:SetScript("OnEnter", function()
      if OnEnter then OnEnter() end
      GameTooltip_SetDefaultAnchor(GameTooltip, this)

      GameTooltip:SetText(this.caption:GetText())
      GameTooltip:AddLine(buttons[this:GetID()].tooltip, 1, 1, 1, true)
      GameTooltip:SetWidth(100)
      GameTooltip:Show()
    end)

    local OnLeave = pfQuestInit[i]:GetScript("OnLeave")
    pfQuestInit[i]:SetScript("OnLeave", function()
      if OnLeave then OnLeave() end
      GameTooltip:Hide()
    end)
  end

  -- show arrows
  pfQuestInit.checkbox = CreateFrame("CheckButton", nil, pfQuestInit, "UICheckButtonTemplate")
  pfQuestInit.checkbox:SetPoint("BOTTOMLEFT", 10, 10)
  pfQuestInit.checkbox:SetNormalTexture("")
  pfQuestInit.checkbox:SetPushedTexture("")
  pfQuestInit.checkbox:SetHighlightTexture("")
  pfQuestInit.checkbox:SetWidth(22)
  pfQuestInit.checkbox:SetHeight(22)
  pfUI.api.CreateBackdrop(pfQuestInit.checkbox, nil, true)

  pfQuestInit.checkbox.caption = pfQuestInit:CreateFontString("Status", "LOW", "GameFontWhite")
  pfQuestInit.checkbox.caption:SetPoint("LEFT", pfQuestInit.checkbox, "RIGHT", 5, 0)
  pfQuestInit.checkbox.caption:SetJustifyH("LEFT")
  pfQuestInit.checkbox.caption:SetText(L["Mostrar flecha de navegación"])
  pfQuestInit.checkbox:SetScript("OnClick", function()
    config_stage.arrow = this:GetChecked()
  end)

  pfQuestInit.checkbox:SetScript("OnEnter", function()
    GameTooltip_SetDefaultAnchor(GameTooltip, this)
    GameTooltip:SetText(L["Flecha de navegación"])
    GameTooltip:AddLine(L["Muestra la flecha de navegación que te señala la ubicación de misión más cercana."], 1, 1, 1, true)
    GameTooltip:SetWidth(100)
    GameTooltip:Show()
  end)

  pfQuestInit.checkbox:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  -- save button
  pfQuestInit.save = CreateFrame("Button", nil, pfQuestInit)
  pfQuestInit.save:SetWidth(100)
  pfQuestInit.save:SetHeight(24)
  pfQuestInit.save:SetPoint("BOTTOMRIGHT", -10, 10)
  pfQuestInit.save.text = pfQuestInit.save:CreateFontString("Caption", "LOW", "GameFontWhite")
  pfQuestInit.save.text:SetAllPoints(pfQuestInit.save)
  pfQuestInit.save.text:SetText("Guardar y cerrar")

  pfUI.api.SkinButton(pfQuestInit.save)

  pfQuestInit.save:SetScript("OnClick", function()
    -- write current config
    if config_stage.mode == 1 then
      pfQuest_config["showspawn"] = "0"
      pfQuest_config["showspawnmini"] = "0"
      pfQuest_config["showcluster"] = "1"
      pfQuest_config["showclustermini"] = "1"
    elseif config_stage.mode == 2 then
      pfQuest_config["showspawn"] = "1"
      pfQuest_config["showspawnmini"] = "1"
      pfQuest_config["showcluster"] = "1"
      pfQuest_config["showclustermini"] = "0"
    elseif config_stage.mode == 3 then
      pfQuest_config["showspawn"] = "1"
      pfQuest_config["showspawnmini"] = "1"
      pfQuest_config["showcluster"] = "0"
      pfQuest_config["showclustermini"] = "0"
    end

    if config_stage.arrow then
      pfQuest_config["arrow"] = "1"
    else
      pfQuest_config["arrow"] = "0"
    end

    -- save welcome flag and reload
    pfQuest_config["welcome"] = "1"
    pfQuest:ResetAll()
    pfQuestInit:Hide()
  end)
end
