# WowGuildInvite
Ever wanted to recruit some guildies without touching the keyboard? well now here is your salvation.

![GitHub all releases](https://img.shields.io/github/downloads/wyvern800/WowGuildInvite/total?color=k)

## What this addon does?
It will spam messages with a limited treshold of five minutes per message (**to avoid mutes or bans**) on any chat you choose (**limited to one atm**) and also set a DND message that players will receive whenever whispering you, that way you can organicly recruit members to your discord or pugs, or any other event you plan on.  

## Required dependencies (comes with this)
[MessageQueue](https://github.com/LenweSaralonde/MessageQueue) from LenweSaralonde  
This dependency is a must have as WoW system has a anti-spam system that can be bypassed by this library [Click here to understand better](https://github.com/LenweSaralonde/MessageQueue#readme)  

## How to install?
1. Place both folders (*MessageQueue, WowGuildInvite*) to your **WoW/_classic_/Interface/Addons** and enable in your game.  
1. Acess the addon configurations by sending the command **/wgi** or access by **ESC/Interfaces/WowGuildInvite**.  
1. Config as your liking and mark the checkbox **Keep Spamming?** to have it spamming.  
1. Now to have the addon working, you gotta execute the file '**MessageQueue/PixelTrigger.ahk**' for that you will need [AutoHotKey](https://www.autohotkey.com/) installed in order to have the script to be executed, what when one or multiple messages are awaiting in the queue, the top left pixel of the WoW client turns gray (#333333). MessageQueue can be used in conjunction with AutoHotkey and the provided PixelTrigger.ahk script to automatically send the hardware event (mouse click on buttn 5) to the World of Warcraft window when it's focused. Detailed info can be found on the creator's docummentation by [clicking here](https://github.com/LenweSaralonde/MessageQueue#readme). As soon you have the script running, leave wow client open or play while it is being executed, and the magic should happen, if you want to stop the spam, just unmark the checkbox **Keep Spamming ?** on the configs page by typing **/wgi**.

Enjoy! And please star if you liked my addon, this was a pain in the #@% to achieve as I had nearly zero lua knowledge :p

## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)

## Credits
[MessageQueue](https://github.com/LenweSaralonde/MessageQueue) by LenweSaralonde  
[Social Media Preview Image](https://github.com/Th3mike) by Th3Mike  

## USE AT YOUR OWN RISK, THIS WAS TESTED FOR A WHILE AND I DIDN'T GET BANNED OR MUTED, SO IF YOU PLAN ON USING THIS, PLEASE DONT CHANGE THE 5 MINUTES COOLDOWN THRESOLD, USING AUTOHOTKEY WONT BAN YOU AS IT ISN'T AGAINST T.O.S
