#Requires AutoHotkey v1.1
#SingleInstance, force
#MaxThreadsPerHotkey 3
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SetWorkingDir, %A_ScriptDir%
#Include <AnkiUploaderFunctions>

; Global Variable comes first
global TaskIsRunning := false
global current_window := ""
global VIM_COPY_DELAY := 120
global NORMAL_DELAY := 100
global AnkiAddWindow := "Add ahk_exe anki.exe"

F12::LoadToAnki(false) ; False means has no copied, so it will copy the text first before load to anki
#F12::Repeater()
F10::LoadToAnki(true) ; True means has copied, so it will just load to anki directly
#F10::UserManual()
F4::JustForAnki()
XButton2::LoadWithTab() 
XButton1::LoadWithEnter()
Insert::LoadWithTab() 
Home::LoadWithEnter()
;F9::VimDoubleCopy()

