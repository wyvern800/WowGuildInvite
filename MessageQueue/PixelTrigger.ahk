; Install AutoHotkey to run this script https://www.autohotkey.com/
; Triggers mouse BUTTON5 when the pixel at the top left corner turns gray (#333333), meaning that a message has to be sent by MessageQueue.
; WoW should run in full screen mode on the leftmost monitor for this script to work.
; If you use a different binding as mouse BUTTON5, make a copy of this script and edit line 10 of the script below.

CoordMode, Pixel, Client

Loop {
	if WinActive("World of Warcraft") {
		; Get pixel color at the top left corner
		PixelGetColor, color, 0, 0

		if (color = "0x333333") {
			MouseClick, X2 ; Trigger mouse click on BUTTON5 (X2)
			Random delay, 400, 600
			Sleep delay ; avoid spamming button and being accidentally flagged for botting by WoW's anti-cheat system.
		}
	}

	Sleep 5 ; 5ms corresponds to 200 FPS/Hz. Should fit all screen refresh rates.
}
