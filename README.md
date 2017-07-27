# Web-Tac-Toe
Web-Tac-Toe is a Sinatra port of my simple CLI "Tic-Tac-Toe with AI" project.

![Log-In Screen](/public/images/screenshots/01_login.png?raw=true "Log-In Screen")
### Logging In
On the main page, a preview of the game board interface is displayed under the login form. An account must be created in order to play.

![New Game Screen](/public/images/screenshots/01_login.png?raw=true "New Game Screen")
### New Game
On the New Game screen, you may challenge the computer or invite another player to a game (if a user has currently invited, been invited by, or have an ongoing game with another user, they will not be able to send a new invite to that user).

![Game Screen](/public/images/screenshots/01_login.png?raw=true "Game Screen")
### Playing a Game
On a Game screen, the game board will be displayed, along with the game's status and links to the players' profile pages.
Players of the game will also have the option to forfeit the game or place a token if it's their turn.

In a game against the computer, the page will automatically refresh when the computer has made its move. In a game against another player, the page must be refreshed manually to see if the opponent has made their move.

![Profile Screen](/public/images/screenshots/01_login.png?raw=true "Profile Screen")
### Profile Pages
Displayed on a user's profile page is a grid of board previews linking to their ongoing games, along with their game performance history (number of games won and lost against previous opponents, and an overal win&tie/loss ratio).

On a user's own profile page, they will also see a list of sent and received game invites, with the option to delete sent invites or ignore received invites (the sender will remain unaware).

---

## Installation
To play the game locally, clone the repo and run `bundle install` from the game directory.
Then, run `shotgun` and navigate to `localhost:9393` in your browser.

---

## Contributing
Feel free to submit a pull request.

---

## License

This is free and unencumbered software released into the public domain.

For more information, please refer to `UNLICENSE.md` or <https://unlicense.org>.