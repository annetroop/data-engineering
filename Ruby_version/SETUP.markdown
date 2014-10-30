I believe you have Ruby on Rails set up, so I'm thinking I don't have to go into installation details.  :^)  I did my installing from railsinstaller.org, followed by gem update rails to get to rails 4.1.6.

If you put the convert directory in your rails top-level directory (that which is "c:\Sites" by default), you should then follow these steps:

- cd convert
- rake db:migrate RAILS_ENV=development
- rails server

- go to http://localhost:3000
- Click "Choose file"
- browse to convert\inputs directory to find simple_input.tab (no duplicates), example_input.tab or more_input.tab
- Click "Open"
- Click "Import"

This will import the tab separated file into 3 database tables:

purchasers, containing (unique) purchaser name and a purchaser id;
merchants, containing (unique) merchant name, merchant address, and a merchant id;
and items, containing item description, item price, purchase count, and a purchaser id and merchant id

It will bring you to a page showing the items table, with links to click through the merchant id or purchaser id, and also links to go to the list of merchants or the list of purchasers.

This is my first week doing Ruby on Rails, so please be generous in interpreting my lack of knowledge of the finer points of the language.  :^)

Thanks!
Anne
 