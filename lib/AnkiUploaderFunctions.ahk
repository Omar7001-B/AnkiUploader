#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
Menu, Tray, Icon, Shell32.dll, 176
SendInput, {+ Up}
SendInput, {^ Up}
SendInput, {! Up}
SendInput, {# Up}
; ---------------- Basic Loader ----------------
LoadToAnki(copied){
    TaskCheckerReload()
    WinGetActiveTitle, current_window
    if WinExist(AnkiAddWindow)
    {
        TaskIsRunning := true
        if(!copied)
            VimDoubleCopy()
        WinActivate, %AnkiAddWindow%
        DoublePaste()
        AddCard()
        WinActivate, %current_window%
        TaskIsRunning := false
    }
    else
    {
        MsgBox, Please open the Add window first
        return
    }
}

; ---------------- #F12 ----------------
Repeater(){
    TaskCheckerReload()
    InputBox, LoopCount, Enter Number of cards?, How many number of flashCards you want to add? , LoopCount , 320, 100
    Loop %LoopCount%
        LoadToAnki(false)
    return
}

; ---------------- #F10 ----------------
UserManual(){
    instructions := ""
    instructions .= "This program can be used in two ways:`n"
    instructions .= "1. Loading copied information using F10:`n"
    instructions .= "- Open the Anki 'Add Card' tab and leave`it open`n"
    instructions .= "- Take a screenshot of the answer (back of flashcard) first, then the question (front of flashcard)`n"
    instructions .= "- Press F10 and the screenshots will be loaded into a flashcard in Anki, ready for the next one`n"
    instructions .= "2. Loading information from apps that support macros, such as Obsedian, using Vim:`n"
    instructions .= "- Open the Anki 'Add Card' tab and leave it open`n"
    instructions .= "- Set up macros for copying the front (question) of the flashcard to 'q' and the back (answer) of the flashcard to 'w'`n"
    instructions .= "- Press F12 to load 'q' and 'w' into a flashcard in Anki`n"
    instructions .= "- Bonus: You can load multiple lines at once by pressing Window + F12. Make sure to move to the next line in 'q' before copying to ensure the loop works properly.`n"
    ; make a message box that shows the instructions, and instead of the ok button show "Let's go" button
    MsgBox, %instructions%

}
; ---------------- Interrupt Task ----------------
TaskCheckerReload(){
    if(TaskIsRunning)
    {
        Reload
        return
    }
}

; ---------------- VIM Section ----------------
VimDoubleCopy(){
    VimMacroGo("w") ; Second Field
    VimMacroGo("q") ; First Field
}

VimMacroGo(key){
    SendWithDelay("{Shift Down}", VIM_COPY_DELAY)
    SendWithDelay("2", VIM_COPY_DELAY)
    SendWithDelay("{Shift Up}", VIM_COPY_DELAY)
    SendWithDelay(key, VIM_COPY_DELAY)
    return
}

SendWithDelay(key, delay){
    SendInput, %key%
    Sleep, %delay%
    return
}

; ---------------- Anki Sending ----------------
DoublePaste(){
    SendWithDelay("^v", NORMAL_DELAY)
    SendWithDelay("{Tab}", NORMAL_DELAY)
    SendWithDelay("#v", NORMAL_DELAY)
    SendWithDelay("{Down}", NORMAL_DELAY)
    SendWithDelay("{Enter}", NORMAL_DELAY)
}

; ---------------- Anki Add Card ----------------
AddCard(){
    SendWithDelay("{Ctrl Down}", NORMAL_DELAY)
    SendWithDelay("{Enter}", NORMAL_DELAY)
    SendWithDelay("{Ctrl Up}", NORMAL_DELAY)
}

; ---------------- Trash Section ----------------
; CapsLock::
;     WinActivate, Add ahk_exe anki.exe
; return

; F10::
;     delay := 70
;     if(!TaskIsRunning)
;     {
;         TaskIsRunning := true
;         ; send alt + tab (Sending To Anki Now)
;         SendInput, {Alt down}
;         Sleep delay
;         SendInput, {Tab}
;         Sleep delay
;         SendInput, {Alt up}
;         Sleep delay
;         SendInput, ^v
;         ; Paste firest field (last Copy)
;         Sleep delay
;         SendInput, {Tab}
;         Sleep delay
;         SendInput, #v
;         ; paste second field (first copy)
;         Sleep delay+delay+delay
;         SendInput, {Down}
;         Sleep delay
;         SendInput, {Enter}
;         Sleep delay+delay+delay
;         Send ^{enter}
;         sleep delay
;         ; ----- Alt + Tab ---
;         SendInput, {Alt down}
;         Sleep delay
;         SendInput, {Tab}
;         Sleep delay
;         SendInput, {Alt up}
;         TaskIsRunning := false
;         return
;     }
; Return

; first thing open the Add Window of Anki
; To load things with copy (through Vim) Use F12 for a single card and #F12 for multiple cards
; Make Sure  q is the first field and w is the second field
; to load things with manual copy use F10 for a single card
; for example you can load screen shots, make sure you're following LIFO principle
; Last screenshot will be your first fireld, and first secreen shot will be your second field
; os you make take a screen shot of the answer first, then take a screen shot of the answer