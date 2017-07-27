# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
> Self-explanatory.

- [X] Use ActiveRecord for storing information in a database
> All object information is

- [X] Include more than one model class (list of model class names e.g. User, Post, Category)
> Game, User, Invite

- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
> A `User` `has_many` `:games_as_player_1`, `:games_as_player_2`, `:won_games`, `:lost_games`, `:received_invites`, and `:sent_invites`.

- [X] Include user accounts
> Users must sign up in order to interact with anything except the login and signup teaser page.

- [X] Ensure that users can't modify content created by other users
> Every button that can modify data is hidden from unauthorized users, and requests to modify data are protected by additional checks within the controllers.

- [X] Include user input validations
> Usernames must be unique (case-insensitive), between 4-32 characters, and cannot include the word 'computer'.

- [X] Display validation failures to user with error message (example form URL e.g. /posts/new)
> Customized ActiveRecord validation errors are displayed on signup. In addition, Rack::Flash is used to display various messages throughout the site.

- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
> Done.


Confirm
- [X] You have a large number of small Git commits
> 121 commits, 1,459 additions and 221 deletions.

- [X] Your commit messages are meaningful
> Each message lists the exact change, or the intent (if meaningfulness isn't obvious, or specific changes would be too numerous to list).

- [X] You made the changes in a commit that relate to the commit message
> A line or two would escape every once in a while, but if I caught it quickly enough I would roll back and redo the commit.

- [X] You don't include changes in a commit that aren't related to the commit message
> 95% of the time. Due to the nature of HTML/CSS, lots of cosmetic/page-structural changes get wrapped up in functional changes.

