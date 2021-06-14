--[[
  Author: wyvern800
  Character: Slayerhawk (TBC Faerlina)
]]
local wgi = CreateFrame'Frame'

local dndSet = false;

local saved = false;
local last_check;

-- Holds the main event
function WowGuildInviteEvent(self, event, arg1)
  if (event == "ADDON_LOADED" and WowGuildInvite_ChannelBox == nil) then
    WowGuildInvite_CreateOptions();
    WowGuildInvite_AddonLoadedOptions();
    print("|cffff00ff[WowGuildInvite]|r loaded, type /wgi to open the configurations! - created by wyvern800")
    return
  end
end

-- Processes the addon behavior
function Process()
  if (WowGuildInvite.addonEnabled == false) then
    return
  end

  -- Broadcasts the message to the specified channel
  if (WowGuildInvite.channel ~= nil) then
    local channel = GetChannelName(string.lower(WowGuildInvite.channel));
    if (channel ~= nil) then
      --SendChatMessage(WowGuildInvite.message, "CHANNEL", nil, channel)

      MessageQueue.SendChatMessage(WowGuildInvite.message, 'CHANNEL', nil, channel, function()
        
      end)

      if (dndSet == false) then
        SendChatMessage(WowGuildInvite.dnd, "DND", nil, nil)
        dndSet = true;
      end

      wgi:UnregisterEvent('ADDON_LOADED', nil)
      --print("already sent");
    end
  end
end

do
  function wgi.UPDATE()
    if saved == false then
      Process()
      last_check = GetTime();
      saved = true;
     elseif GetTime() >= last_check + 300 then
      saved = false
    else
      --print(GetTime())
    end
  end
end

-- Creates the frame & register event
wgi:SetScript("OnEvent", WowGuildInviteEvent)
wgi:SetScript('OnUpdate', function() wgi.UPDATE() end)
wgi:RegisterEvent("ADDON_LOADED")
C_ChatInfo.RegisterAddonMessagePrefix("WowGuildInvite")

-- Process the commands
local function Commands(msg, editbox)
  if msg == "run" then
    Process()
  elseif msg == "reset" then
    ResetConfigs()
  else
    InterfaceOptionsFrame_OpenToCategory("WowGuildInvite")InterfaceOptionsFrame_OpenToCategory("WowGuildInvite")
  end
end
SLASH_WGI1, SLASH_WGI2 = "/wgi", "/wowguildinvite"
SlashCmdList["WGI"] = Commands
