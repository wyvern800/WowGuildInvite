-- Our database
WowGuildInvite = {
  channel = "LookingForGroup",
  message = "This is a message that will be spammed to the channels | leave this here whisper me [info] to know better about it!",
  dnd = "Thank you for the interest | Whisper me [inv] for an auto invite or [discord] to get our guild discord link!",
  invitingCallback = "I sent you the guild invitation, thanks for joining if you accept, if you still need our discord link, whisper me [discord] or [disc]!",
  discordLink = "https://discordlinkhere.gg",
  addonEnabled = false,
}

local prefix = "|cffff00ff[WowGuildInvite]|r"

-- Resets the configs
function ResetConfigs()
  WowGuildInvite_AddonLoadedOptions()
  print(prefix.." Settings resetted!")
end

-- Loads the options
function WowGuildInvite_AddonLoadedOptions()
  WowGuildInvite_ChannelBox:SetText(WowGuildInvite.channel);
  --WowGuildInvite_DelayBox:SetText(WowGuildInvite.delay);
  WowGuildInvite_MessageBox:SetText(WowGuildInvite.message);
  WowGuildInvite_DNDBox:SetText(WowGuildInvite.dnd);
  WowGuildInvite_InvBox:SetText(WowGuildInvite.invitingCallback);
  WowGuildInvite_DiscordBox:SetText(WowGuildInvite.discordLink);
  --WowGuildInvite_DelayBox:SetCursorPosition(0)
  WowGuildInvite_ChannelBox:SetCursorPosition(0)
  WowGuildInvite_MessageBox:SetCursorPosition(0);
  WowGuildInvite_DNDBox:SetCursorPosition(0);
  WowGuildInvite_InvBox:SetCursorPosition(0);
  WowGuildInvite_DiscordBox:SetCursorPosition(0);
  WowGuildInvite_EnabledCheck:SetChecked(WowGuildInvite.addonEnabled);

end

function WowGuildInvite_CreateOptions()
  local options = CreateFrame("Frame", "WowGuildInvite_Options")
  options.name = "WowGuildInvite"
  InterfaceOptions_AddCategory(options);

  -- Channel
  WowGuildInvite_Options_CreateLabel(0, 0, "WowGuildInvite Config");
  WowGuildInvite_Options_CreateLabel(0, 40, "Invite Channel")
  WowGuildInvite_Options_CreateEditbox(160, 40, false, "WowGuildInvite_ChannelBox")
	WowGuildInvite_ChannelBox:SetScript("OnTextChanged", function()
		WowGuildInvite.channel = WowGuildInvite_ChannelBox:GetText();
	end);

  -- Discord link
  WowGuildInvite_Options_CreateLabel(300, 40, "Discord Link")
  WowGuildInvite_Options_CreateEditbox(440, 40, false, "WowGuildInvite_DiscordBox")
	WowGuildInvite_DiscordBox:SetScript("OnTextChanged", function()
		WowGuildInvite.discordLink = WowGuildInvite_DiscordBox:GetText();
	end);

  -- Creates the cooldown widget
  --[[WowGuildInvite_Options_CreateLabel(0, 80, "Msg. Cooldown")
  WowGuildInvite_Options_CreateEditbox(160, 80, true, "WowGuildInvite_DelayBox")
	WowGuildInvite_DelayBox:SetScript("OnTextChanged", function()
    if(WowGuildInvite_DelayBox:IsNumeric()) then
			WowGuildInvite.channel = WowGuildInvite_DelayBox:GetNumber();
    else
      WowGuildInvite.channel = WowGuildInvite_DelayBox:GetText();
		end
	end);]]--

  -- Creates the message widget
  WowGuildInvite_Options_CreateLabel(0, 80, "Broadcast")
  WowGuildInvite_Options_CreateEditboxLarge(160, 80, "WowGuildInvite_MessageBox")
	WowGuildInvite_MessageBox:SetScript("OnTextChanged", function()
		WowGuildInvite.message = WowGuildInvite_MessageBox:GetText();
	end);

  -- Creates the DND widget
  WowGuildInvite_Options_CreateLabel(0, 120, "Response")
  WowGuildInvite_Options_CreateEditboxLarge(160, 120, "WowGuildInvite_DNDBox")
	WowGuildInvite_DNDBox:SetScript("OnTextChanged", function()
		WowGuildInvite.dnd = WowGuildInvite_DNDBox:GetText();
    --WowGuildInvite.dndSet = false;
	end);

  -- Creates the invitation msg widget
  WowGuildInvite_Options_CreateLabel(0, 160, "Post Invite")
  WowGuildInvite_Options_CreateEditboxLarge(160, 160, "WowGuildInvite_InvBox")
	WowGuildInvite_InvBox:SetScript("OnTextChanged", function()
		WowGuildInvite.invitingCallback = WowGuildInvite_InvBox:GetText();
	end);

  -- Creates the keep spamming checkbox
  WowGuildInvite_Options_CreateCheckbutton(-5, 200, "WowGuildInvite_EnabledCheck","Keep Spamming?");
  WowGuildInvite_EnabledCheck:SetScript("OnClick", function()
        --[[if WowGuildInvite.addonEnabled == false then
          WowGuildInvite.dndSet = false;
        end]]--
        WowGuildInvite.addonEnabled =  WowGuildInvite_EnabledCheck:GetChecked();
	  end);
    WowGuildInvite_Options_CreateLabel2(0, 240, "Addon created by wyvern800 - (Slayerhawk TBC Faerlina)");
  end

  -- Function used to draw checkbutton
  function WowGuildInvite_Options_CreateCheckbutton(xOffset, yOffset, name, text)
  local uiObject = CreateFrame("CheckButton", name,  WowGuildInvite_Options, "ChatConfigCheckButtonTemplate");
    uiObject:SetPoint("TOPLEFT", xOffset + 16, -yOffset - 16);
    getglobal(name .. 'Text'):SetText(text);
  end

  -- Function used to draw label
  function WowGuildInvite_Options_CreateLabel(xOffset, yOffset, text)
    local uiObject = WowGuildInvite_Options:CreateFontString(nil, "Overlay");
    uiObject:SetPoint("TOPLEFT", xOffset + 16, -yOffset - 16);
	  uiObject:SetTextColor(1, 0.8, 0);
    uiObject:SetFont("Fonts\\FRIZQT__.TTF", 16);
    uiObject:SetText(text);

    --[[local MyFrame = CreateFrame("Frame", "MyFrame")
    MyFrame:SetFrameStrata("HIGH")
    MyFrame:SetFrameLevel(5)
    MyFrame:SetToplevel(true)

    uiObject:SetScript("OnEnter", function()
      MyFrame:SetAlpha(1);
    end);

    uiObject:SetScript("OnLeave", function()
      MyFrame:SetAlpha(0);
    end);]]--
end

-- Function used to draw label
function WowGuildInvite_Options_CreateLabel2(xOffset, yOffset, text)
  local uiObject = WowGuildInvite_Options:CreateFontString(nil, "Overlay");
  uiObject:SetPoint("TOPLEFT", xOffset + 16, -yOffset - 16);
  uiObject:SetTextColor(1, 50, 0);
  uiObject:SetFont("Fonts\\FRIZQT__.TTF", 12);
  uiObject:SetText(text);

  --[[local MyFrame = CreateFrame("Frame", "MyFrame")
  MyFrame:SetFrameStrata("HIGH")
  MyFrame:SetFrameLevel(5)
  MyFrame:SetToplevel(true)

  uiObject:SetScript("OnEnter", function()
    MyFrame:SetAlpha(1);
  end);

  uiObject:SetScript("OnLeave", function()
    MyFrame:SetAlpha(0);
  end);]]--
end

-- Function used to draw edit box
function WowGuildInvite_Options_CreateEditbox(xOffset, yOffset, numeric, name, text)
  local uiObject = CreateFrame("EditBox", name, WowGuildInvite_Options, "InputBoxTemplate");
  uiObject:SetPoint("TOPLEFT", WowGuildInvite_Options, "TOPLEFT", xOffset, -yOffset + 13);
  uiObject:SetWidth(140);
  uiObject:SetHeight(80);
  uiObject:SetMaxLetters(25);
	uiObject:SetAutoFocus(false);
  if(numeric) then
	  uiObject:SetMaxLetters(4);
    uiObject:SetNumeric()
  end
	uiObject:SetScript("OnEnterPressed", function()
		uiObject:ClearFocus();
	end);
  return uiObject;
end

-- Function used to draw large edit box
function WowGuildInvite_Options_CreateEditboxLarge(xOffset, yOffset, name, text)
  local uiObject = CreateFrame("EditBox", name, WowGuildInvite_Options, "InputBoxTemplate");
  uiObject:SetPoint("TOPLEFT", WowGuildInvite_Options, "TOPLEFT", xOffset, -yOffset + 13);
  uiObject:SetWidth(450);
  uiObject:SetHeight(80);
	uiObject:SetAutoFocus(false);
	uiObject:SetScript("OnEnterPressed", function()
		uiObject:ClearFocus();
	end);
  return uiObject;
end