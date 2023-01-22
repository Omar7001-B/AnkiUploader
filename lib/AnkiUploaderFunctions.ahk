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
        {
            VimDoubleCopy()
            ; Sleep, (VIM_COPY_DELAY)
        }
        WinActivate, %AnkiAddWindow%
        DoublePaste()
        ; Sleep, (5 * NORMAL_DELAY)
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
    instructions .= "Open the Anki 'Add Card' tab and leave it open`n`n"
    instructions .= "1. Loading copied F10:`n"
    instructions .= "First : Take a screenshot of the answer (back of flashcard)`nSecond : Take SecreenShot of the question (front of flashcard)`n`n"
    instructions .= "2. Loading information with Vim:`n"
    instructions .= "First : Set up macros `n Q --> front (Question)`n W --> back (Answer)`n`n"
    instructions .= "When you press F12:`nIn ViM Will Send @W then @Q`nIn Anki Will Send Ctrl+V (Q), Then tab #V + Down (W)`n`n"
    instructions .= "Bonus: You can load multiple lines at once by pressing Window + F12.`nMake sure to move to the next line in 'q' after copying to ensure the loop works properly.`n"
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
    SendWithDelay("@", VIM_COPY_DELAY)
    SendWithDelay(key, 2 * VIM_COPY_DELAY)
    ; SendWithDelay("2{Shift Up}", VIM_COPY_DELAY)
    ; SendWithDelay("{Shift Up}", 0)
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
    SendWithDelay("{Enter}", 2 * NORMAL_DELAY)
}

; ---------------- Anki Add Card ----------------
AddCard(){
    SendWithDelay("^{Enter}", NORMAL_DELAY)
    ; SendWithDelay("{Enter}", NORMAL_DELAY)
    ; SendWithDelay("{Ctrl Up}", 2 * NORMAL_DELAY)
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