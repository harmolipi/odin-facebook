# Building Facebook
Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

View on [Github](https://github.com/harmolipi/odin-facebook).

### Functionality

This is the [Building Facebook](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/rails-final-project) project, where I make a simple Facebook clone.

### Notes
I had some trouble setting up the postgres database for development (other times I've just used sqlite3), so I'm putting some notes down to remember what I had to do to set it up for next time.

1. Install postgresql:
`sudo apt-get install postgresql`
2. Set environment variable:
`export DATABASE_URL=postgres://$(whoami)`
3. Create database user with the same name as Linux user profile:
`sudo -u postgres createuser -s $(whoami) -P`
4. Set that the password in database.yml via an environment variable.

### Thoughts

Tbd...

God bless.

-Niko Birbilis
