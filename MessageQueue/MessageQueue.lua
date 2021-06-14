MessageQueue = {}

-- Default binding key
local BINDING_KEY = "BUTTON5" -- Mouse button 5

local queue = {}
local updaterFrame
local queueFrame

--- Main initialization
--
MessageQueue.Init = function()
	-- Create gray pixel frame at the top left corner for external key triggering
	queueFrame = CreateFrame('Frame', 'MessageQueueFrame')
	queueFrame:EnableMouse(true)
	queueFrame:SetSize(1, 1)
	queueFrame:SetPoint('TOPLEFT')
	queueFrame:Hide()
	queueFrame.texture = queueFrame:CreateTexture('MessageQueueFrameTexture', 'OVERLAY', nil, 7)
	queueFrame.texture:SetColorTexture(0.2, 0.2, 0.2, 1) -- #333333
	queueFrame.texture:SetAllPoints()
	queueFrame:SetScript("OnMouseDown", MessageQueue.Run) -- You can also click the pixel to run the queue

	-- Create updater frame
	updaterFrame = CreateFrame('Frame')
	updaterFrame:SetScript('OnUpdate', function()
		if #queue > 0 then
			queueFrame:SetFrameStrata('TOOLTIP')
			queueFrame:SetFrameLevel(UIParent:GetFrameLevel() + 1000)
			queueFrame:Show()
		else
			queueFrame:Hide()
		end
	end)

	-- Declare commands
	SlashCmdList["MESSAGEQUEUE"] = MessageQueue.Run
	SLASH_MESSAGEQUEUE1 = "/mq"
	SLASH_MESSAGEQUEUE2 = "/msgqueue"
	SLASH_MESSAGEQUEUE3 = "/messagequeue"

	-- Declare binding strings
	BINDING_HEADER_MESSAGEQUEUE_HEADER = "Message queue"
	BINDING_NAME_MESSAGEQUEUE = "Send message in queue"

	-- Set default binding
	MessageQueue.InitBinding()
end

--- Set the default binding, if needed
--
MessageQueue.InitBinding = function()
	if GetBindingKey("MESSAGEQUEUE") == nil and GetBindingByKey(BINDING_KEY) == nil then
		SetBinding(BINDING_KEY, "MESSAGEQUEUE")
	end
end

--- Enqueue a function
-- @param f (function)
MessageQueue.Enqueue = function(f)
	table.insert(queue, f)
end

--- Enqueue a chat message.
-- Same parameters as the regular SendChatMessage
-- Allows an optional callback that will run after the message has been sent.
-- The callback sould not contain any other hardware triggered function.
-- @param msg (string)
-- @param chatType (string)
-- @param [languageID (string)]
-- @param [channel (string)]
-- @param [callback (function)]
MessageQueue.SendChatMessage = function(msg, chatType, languageID, channel, callback)
	if chatType == 'CHANNEL' or chatType == 'SAY' or chatType == 'YELL' then
		MessageQueue.Enqueue(function()
			SendChatMessage(msg, chatType, languageID, channel)
			if callback then
				callback()
			end
		end)
	else
		SendChatMessage(msg, chatType, languageID, channel)
		if callback then
			callback()
		end
	end
end

--- Run the first item in the queue
-- Should be triggered by a hardware event
MessageQueue.Run = function(f)
	if #queue > 0 then
		table.remove(queue, 1)()
	end
end

--- Returns the number of messages awaiting in queue
-- @return (number)
MessageQueue.GetNumPendingMessages = function()
	return #queue
end

-- Initialize on startup
MessageQueue.Init()