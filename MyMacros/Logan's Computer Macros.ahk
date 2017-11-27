;To run make sure to install nircmd in system 32, and Autohotkey
;It's being weird so run it with the script in atom in background

	;Autohotkey: https://autohotkey.com/
	;Autohotkey is really simple to install so just follow the prompts and stuff

	;Nircmd: http://www.nirsoft.net/utils/nircmd.html
	;Nircmd gives really weird (to me) instructions for how to install so:
	;Extract .zip file with winrar to system 32 (C:\Windows\System32)

;And that's about it just run this script with both of the above installed


;So far the commands in this autokey/nircmd script are:

;	Ctrl+Shift+Scroll up/down: clipboard history

;With numlock OFF

	;NumpadDot: Open google chrome

	;Numpad0: Pause/play

	;Numpad1: Media Last

	;Numpad2: Media next

	;Numpad3: Open Control panel

	;Numpad4: Mute volume

	;Numpad5: Un-mute volume

	;Numpad6: Open Notepad

	;Numpad7: Inserts leprkon56@gmail

	;Numpad8: Inserts Cornholiday@gmail

	;Numpad9: Run Overwatch (Best Game Ever)

	;Numpad+: Audio switcher by Pat from obrienlabs.net
		;Audio Switcher source code: https://obrienlabs.net/use-autohotkey-toggle-default-playback-sound-device/
		;clipboard history source code; https://autohotkey.com/board/topic/72189-simple-clipboard-history/

;░░░░░░░░▄██████▄
;░░░░░░░█▀▀▀██▀▀▀▄
;░░░░░░░█▄▄▄██▄▄▄█ U HAVE BEEN ABDUCTED BY
;░░░░░░░▀█████████
;░░░░░░░░▀███▄███▀░░ THE AYYLIEN
;░░░░░░░░░▀████▀░░░░░
;░░░░░░░▄████████▄░░░░ THIS IS LOGANS MACRO SCRIPT
;░░░░░░████████████░░░░ USE IT OR GET PROBERED
;ASCII art is really cool give me a break

#Persistent			; Keeps script permanently running.
#SingleInstance		; Only allows one instance of the script to run.

;Random hotstring examples
;When you type the characters in the :: :: it inputs what follows
	::wtf::What the fuck
	::yfmb::You fucked my bestfreind

;!!WANRING!! Turn off caps lock for commands on Numpad

	;open google chrome
		NumpadDel::
			Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe, Max
			Return

	;Media Pause
		NumpadIns::
			Send, {Media_Play_Pause}
			return

;Media last
	NumpadEnd::
		Send, {Media_Prev}
		return

;media next
	NumpadDown::
		Send, {Media_Next}
		return

;open control panel
	NumpadPgDn::
		Run control panel
		return

;open Notepad
	NumpadRight::
		Run %SystemRoot%\system32\notepad.exe
		return

;un-mute audio
	NumpadClear::
		Run nircmd.exe mutesysvolume 0
		return

;mute audio
	NumpadLeft::
		Run nircmd.exe mutesysvolume 1
		return

;Run overwatch
	NumpadPgUp::
		Run C:\Program Files (x86)\Overwatch\Overwatch Launcher.exe
		return

;attempt for email input leprkon56@gmail.com & Cornholiday@gmail.com
	NumpadUp::
		Send, Cornholiday@gmail.com
		return

	NumpadHome::
		Send, leprkon56@gmail.com
		return

;fix for other macro not allowing mouse 4 to work properly
;(poor code so fuck it)it's constant too :*

Xbutton1::Xbutton1

;function to switch audio devices

NumpadAdd::
	toggle:=!toggle ; This toggles the variable between true/false
	if toggle
	{
		Run nircmd setdefaultsounddevice Speaker
		soundToggleBox(Speaker)
	}
	else
	{
		Run nircmd setdefaultsounddevice Headset
		soundToggleBox(Headset)
	}
Return

; Display sound toggle GUI
soundToggleBox(Device)
{
	IfWinExist, soundToggleWin
	{
		Gui, destroy
	}

	Gui, +ToolWindow -Caption +0x400000 +alwaysontop
	Gui, Add, text, x35 y8, Default sound: %Device%
	SysGet, screenx, 0
	SysGet, screeny, 1
	xpos:=screenx-275
	ypos:=screeny-100
	Gui, Show, NoActivate x%xpos% y%ypos% h30 w200, soundToggleWin

	SetTimer,soundToggleClose, 2000
}
soundToggleClose:
    SetTimer,soundToggleClose, off
    Gui, destroy
Return


; Retrieves saved clipboard information since when this script last ran
Loop C:\tmp\clipvar*.txt
{
  clipindex += 1
  FileRead clipvar%A_Index%, %A_LoopFileFullPath%
  FileDelete %A_LoopFileFullPath%
}
maxindex := clipindex
OnExit ExitSub

; Clears the history by resetting the indices
+NumpadMult::
+NumpadSub::
tooltip clipboard history cleared
SetTimer, ReSetToolTip, 1000
maxindex = 0
clipindex = 0
Return

; Scroll up and down through clipboard history
^+WheelUp::
if clipindex > 1
{
  clipindex -= 1
}
thisclip := clipvar%clipindex%
clipboard := thisclip
tooltip %clipindex% - %clipboard%
SetTimer, ReSetToolTip, 1000
Return
^+WheelDown::
if clipindex < %maxindex%
{
  clipindex += 1
}
thisclip := clipvar%clipindex%
clipboard := thisclip
tooltip %clipindex% - %clipboard%
SetTimer, ReSetToolTip, 1000
Return

; Add clipboard contents to the stack when you copy or paste using the keyboard
~^x::
~^c::
Sleep 500
clipindex += 1
clipvar%clipindex% := clipboard
thisclip := clipvar%clipindex%
tooltip %clipindex% - %thisclip%
SetTimer, ReSetToolTip, 1000
if clipindex > %maxindex%
{
  maxindex := clipindex
}
Return

; Clear the ToolTip
ReSetToolTip:
    ToolTip
    SetTimer, ReSetToolTip, Off
return

; Saves the current clipboard history to hard disk
ExitSub:
SetFormat, float, 06.0
Loop %maxindex%
{
  zindex := SubStr(0000000000 . A_Index, -9)
  thisclip := clipvar%A_Index%
  FileAppend %thisclip%, C:\tmp\clipvar%zindex%.txt
}
ExitApp
