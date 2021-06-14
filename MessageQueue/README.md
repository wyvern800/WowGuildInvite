MessageQueue
============
Implements an alternative to `SendChatMessage()` to securely send messages in chat channels in response to a hardware event.

How it works
------------
Use `MessageQueue.SendChatMessage()` in your add-ons and macros to send chat messages instead of `SendChatMessage()`. MessageQueue will then wait for a specific hardware event (by default mouse button 5) to send the message. A callback that will be executed after the message has been sent can also be provided.

The default hardware event used is a mouse click on button 5. It can be changed in the bindings.

When one or multiple messages are awaiting in the queue, the top left pixel of the WoW client turns gray (#333333). MessageQueue can be used in conjunction with [AutoHotkey](https://www.autohotkey.com/) and the provided `PixelTrigger.ahk` script to automatically send the hardware event (mouse click on button 5) to the World of Warcraft window when it's focused.

If you wish to use another hardware event than mouse button 5, make a copy of the `PixelTrigger.ahk` script and edit it accordingly (instructions are provided within the script comments).

Please be aware that the use of AutoHotkey is not against Blizzard's ToS and you won't get banned for just using it along with WoW. It's commonly used by players with disabilities. Only obvious abuse such as spamming or automating complex actions can get you banned. Do not use any other script than the provided `PixelTrigger.ahk` unless you know what you're doing.

API documentation
-----------------
### MessageQueue.SendChatMessage
`MessageQueue.SendChatMessage("msg" [,"chatType" [,languageID [,"target" [, "callback"]]]]);`
Add a message to the queue if the target requires a hardware event (chatType is either "SAY", "YELL" or "CHANNEL"). For any other chatType, the message is sent instantly.

Arguments are the same as the regular [SendChatMessage](https://wow.gamepedia.com/API_SendChatMessage) function.

The optional **callback** function will be executed when the message has been sent. The callback should not contain any other code requiring a hardware event.

### MessageQueue.Enqueue
`MessageQueue.Enqueue("f");`
Enqueue a function that requires a hardware event to run. The function code should not perform more than one action requiring a hardware event.

Shares the same queue as **MessageQueue.SendChatMessage()**.

### MessageQueue.GetNumPendingMessages
`messageCount = MessageQueue.GetNumPendingMessages()`
Returns the number of messages awaiting in the queue.

### MessageQueue.Run
`MessageQueue.Run()`
Runs the first message awaiting in queue. Should only be called in response to a hardware event. If for some reason the message fails, it won't be possible to attempt it again.

Integration guide
-----------------
The integration of MessageQueue in your add-on is pretty straightforward.

First, add MessageQueue as a required dependency for your add-on by adding the following in the .toc file:
`## RequiredDeps: MessageQueue`

Then, just replace `SendChatMessage()` calls by `MessageQueue.SendChatMessage()`.

However, keep in mind that the message will not be sent instantly (for example if the World of Warcraft window is not in focus). If the rest of your code requires the message to be actually sent, you should pause the execution of the current process then resume it in the callback.

Before
```lua
SendChatMessage(text, 'SAY')
-- Do stuff
return
```

After
```lua
MessageQueue.SendChatMessage(text, 'SAY', nil, nil, function()
	-- Do stuff
	-- Resume process execution
end)
-- Pause process execution
return
```

The functions `MessageQueue.Enqueue` and `MessageQueue.Run` can be hooked using `hooksecurefunc()` by your add-on to perform actions when an element has been added or removed from the queue.
