--[[
  Author: wyvern800
  Character: Slayerhawk (TBC Faerlina)
]]
local wgi = CreateFrame'Frame'
--local dndSet = false;
local saved = false;
local last_check;
local prefix = "|cffff00ff[WowGuildInvite]|r"

-- Holds the main event
function WowGuildInviteEvent(self, event, msg, sender, ...)
  if (event == "ADDON_LOADED" and WowGuildInvite_ChannelBox == nil) then
    WowGuildInvite_CreateOptions();
    WowGuildInvite_AddonLoadedOptions();
    print(prefix.." loaded, type /wgi to open the configurations! - created by wyvern800")
    return
  elseif (event == "CHAT_MSG_WHISPER") then
    local channel = GetChannelName(string.lower(WowGuildInvite.channel));

    -- Sends the guild invite through whisper
    if string.lower(msg) == "inv" then
      MessageQueue.SendChatMessage("/i "..sender, 'SAY', nil, nil, function()
        print(prefix.." Guid invite sent to player: "..sender.."!")
        SendChatMessage("[WowGuildInvite] "..WowGuildInvite.invitingCallback, "WHISPER", nil, sender)
      end)
      return

    -- Sends the discord invite link as a whisper
    elseif string.lower(msg) == "discord" then
      if (WowGuildInvite.discordLink == nil) then -- To avoid bugs
        return
      end

      MessageQueue.SendChatMessage("[WowGuildInvite] Discord invite: "..WowGuildInvite.discordLink, 'WHISPER', nil, sender, function()
        print(prefix.." Discord link sent to player: "..sender.."!")
      end)
      return

    -- Sends info about the guild
    elseif string.lower(msg) == "info" then
      MessageQueue.SendChatMessage("[WowGuildInvite] "..WowGuildInvite.dnd, 'WHISPER', nil, sender, function()
        print(prefix.." Whispered the information to player: "..sender.."!")
      end)
      return
    end
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
      MessageQueue.SendChatMessage("[WowGuildInvite] "..WowGuildInvite.message, 'CHANNEL', nil, channel, function()
      end)
      return

      --[[if (dndSet == false and WowGuildInvite.dnd ~= nil) then
        SendChatMessage(WowGuildInvite.dnd, "DND", nil, nil)
        dndSet = true;
      end]]--

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
      --print("saved = true")
     elseif GetTime() >= last_check + 20 then --300
      saved = false
      --print("saved = false")
    else
      --print(GetTime())
    end
  end
end

-- Creates the frame & register event
wgi:SetScript("OnEvent", WowGuildInviteEvent)
wgi:SetScript('OnUpdate', function() wgi.UPDATE() end)
wgi:RegisterEvent("ADDON_LOADED")
wgi:RegisterEvent("CHAT_MSG_WHISPER")

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
