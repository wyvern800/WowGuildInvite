-- Our database
WowGuildInvite = {
  channel = "LookingForGroup",
  message = "This is a message",
  dnd = "This is a DND, set is as you like",
  addonEnabled = false,
}

-- Resets the configs
function ResetConfigs()
  WowGuildInvite_AddonLoadedOptions()
  print("|cffff00ff[WowGuildInvite]|r Settings resetted!")
end

-- Loads the options
function WowGuildInvite_AddonLoadedOptions()
  WowGuildInvite_ChannelBox:SetText(WowGuildInvite.channel);
  --WowGuildInvite_DelayBox:SetText(WowGuildInvite.delay);
  WowGuildInvite_MessageBox:SetText(WowGuildInvite.message);
  WowGuildInvite_DNDBox:SetText(WowGuildInvite.dnd);
  --WowGuildInvite_DelayBox:SetCursorPosition(0)
  WowGuildInvite_ChannelBox:SetCursorPosition(0)
  WowGuildInvite_MessageBox:SetCursorPosition(0);
  WowGuildInvite_DNDBox:SetCursorPosition(0);
  WowGuildInvite_EnabledCheck:SetChecked(WowGuildInvite.addonEnabled);
end

function WowGuildInvite_CreateOptions()
  local options = CreateFrame("Frame", "WowGuildInvite_Options")
  options.name = "WowGuildInvite"
  InterfaceOptions_AddCategory(options);
  WowGuildInvite_Options_CreateLabel(0, 0, "WowGuildInvite Config - Created by wyvern800");
  WowGuildInvite_Options_CreateLabel(0, 40, "Invite Channel")
  WowGuildInvite_Options_CreateEditbox(160, 40, false, "WowGuildInvite_ChannelBox")
	WowGuildInvite_ChannelBox:SetScript("OnTextChanged", function()
		WowGuildInvite.channel = WowGuildInvite_ChannelBox:GetText();
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
  WowGuildInvite_Options_CreateLabel(0, 80, "Invite Message")
  WowGuildInvite_Options_CreateEditboxLarge(160, 80, "WowGuildInvite_MessageBox")
	WowGuildInvite_MessageBox:SetScript("OnTextChanged", function()
		WowGuildInvite.message = WowGuildInvite_MessageBox:GetText();
	end);

  -- Creates the DND widget
  WowGuildInvite_Options_CreateLabel(0, 120, "(DND) Message")
  WowGuildInvite_Options_CreateEditboxLarge(160, 120, "WowGuildInvite_DNDBox")
	WowGuildInvite_DNDBox:SetScript("OnTextChanged", function()
		WowGuildInvite.dnd = WowGuildInvite_DNDBox:GetText();
	end);

  -- Creates the keep spamming checkbox
  WowGuildInvite_Options_CreateCheckbutton(-5, 160, "WowGuildInvite_EnabledCheck","Keep Spamming?");
  WowGuildInvite_EnabledCheck:SetScript("OnClick", function()
        WowGuildInvite.addonEnabled =  WowGuildInvite_EnabledCheck:GetChecked();
		end);
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