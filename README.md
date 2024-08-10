# Hogwarts sorting hat

Hogwarts sorting hat mobile application gives users the ability to guess the relationship between characters and Houses in a similar way to what Magic Hat did in Wizarding World.

## Statements

 - The app consists of 3 screens: Home, List and Details.
 - Display randomly selected personage on the Home screen with renew personage by pull-to-refresh gesture (photo and full name of character).
 - Click the House buttons to guess the affiliation of this character.
 - On every choice, recalculate total/success/failed affiliations and display numbers in the boxes at the top of the Home and List screens.
 - The “Reset” button flushes all previously guessed personages and make all total values equal to zero.
 - On the List screen app displays previously guessed affiliations (successful and failed) and the amount of attempts for every character (until successfully guessed).
 - By clicking on the Reload button against the particular character, load this character on the Home screen with the House buttons again.
 - By clicking on the character item row on the List screen, opened the Details screen. Display personage information only in case this personage has been guessed right.

### Note

Consider that running app on emulator every time gets different getApplicationDocumentsDirectory() so it may cause "can not find file" error because of caching files. If you get it, delete an app from emulator and reinstall it. This error will not appear on real device.