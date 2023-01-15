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
global VIM_COPY_DELAY := 100
global NORMAL_DELAY := 150
global AnkiAddWindow := "Add ahk_exe anki.exe"

F12::LoadToAnki(false)
#F12::Repeater()
F10::LoadToAnki(true)
#F10::UserManual()

