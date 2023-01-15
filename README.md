# Anki Uploader

An AutoHotkey (AHK) script that simplifies the process of creating flashcards in Anki.

## Features

- Two methods for loading information into Anki:
  - Using the F10 key, users can take screenshots of flashcard fronts and backs and easily load them into Anki.
  - By using vim macros and apps that support them, such as Obsidian, users can copy flashcard information to 'q' and 'w' macros and load them into Anki using the F12 key.
- Bonus function that allows users to load multiple lines at once by pressing the Window key + F12.

## Usage

1. Open the Anki 'Add Card' tab and leave it open.
2. Take a screenshot of the answer (back of flashcard) first, then the question (front of flashcard).
3. Press F10 and the screenshots will be loaded into a flashcard in Anki, ready for the next one.
4. Or, if you are using vim apps that support macros
   1. Set up macros for copying the front (question) of the flashcard to 'q' and the back (answer) of the flashcard to 'w'
   2. Press F12 to load 'q' and 'w' into a flashcard in Anki
   3. Bonus: You can load multiple lines at once by pressing Window + F12. Make sure to move to the next line in 'q' before copying to ensure the loop works properly.

## Keybinds

- F10: Copies the last two screenshots taken into an Anki flashcard.
- F12: Runs the 'q/w' macro and pastes the information into an Anki flashcard.
- Windows + F12: Repeats the 'q/w' macro multiple times, saving time.
- Windows + F10: Displays the user manual, in case the user forgets how to use the script.

### Modifying keybinds

You can modify the keybinds by opening the ahk file and change the hotkeys to whatever you want.

## Note

- Please test the script with sample data before using it with real data.

## Contributing

If you would like to contribute to this project, please feel free to submit a pull request.
