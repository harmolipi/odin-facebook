# Building Facebook
Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

View on [Github](https://github.com/harmolipi/odin-facebook).

## Functionality

This is the [Building Facebook](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/rails-final-project) project, where I make a simple Facebook clone. Users can create accounts (with email+password or through Facebook authentication), friend request one another, see their friends' posts on their feed, and like and comment on different posts.

## Notes
### Database
I had some trouble setting up the postgres database for development (other times I've just used sqlite3), so I'm putting some notes down to remember what I had to do to set it up for next time.

1. Install postgresql:
`sudo apt-get install postgresql`
2. Set environment variable:
`export DATABASE_URL=postgres://$(whoami)`
3. Create database user with the same name as Linux user profile:
`sudo -u postgres createuser -s $(whoami) -P`
4. Set that the password in database.yml via an environment variable.

### Omniauth
Also initially had problems setting up Facebook with omniauth, because Facebook required a secure connection. I first resolved it by using a self-signed certificate, but then realized that you can make a test app on Facebook, which doesn't require a secure connection.

### Javascript
Used more javascript files in this project than past ones, and had some trouble figuring out where to put them and how to reference them. Most of my trouble came from the fact that before Rails 6, JS files were handled by the asset pipeline. But as of Rails 6, they're now handled by Webpacker. Most of the guidance I found online applied only to earlier versions, but it wasn't until I found more updated instructions that it all made sense.

In short, `.js` files should be located in the `/app/javascript/packs/` directory, and should be referenced with `javascript_pack_tag`. For example:
`<%= javascript_pack_tag 'mobile_menu', defer: 'defer' %>`

Also, in the above example, `defer: 'defer'` makes it so the file is loaded after the page loads.

### Cloudinary
At the very end, I decided to set up [Cloudinary](https://cloudinary.com/) to both have a good way to host images in production, and also to get some experience in using something other than local storage. I was happy with Cloudinary since it seems they have quite a generous free pricing tier. It was tricky to set up - mostly because I had to change the way I did things. I get the impression that with Active Storage, this isn't the case when using S3 storage, but with Cloudinary, I needed to use their special image tags and way of generating variants on Cloudinary's end, through the [Cloudinary gem](https://github.com/cloudinary/cloudinary_gem). Also, because everything was done differently, I couldn't find a way to continue using local storage in development, so pretty much everything had to switch to Cloudinary. I left in the code for local storage in case I wanted to use it again in the future, and left comments in the code to identify it.

### Thoughts

This project was pretty fun! It was almost intimidating at first, to have such a long list of requirements (basically recreating all the basic functionality of a social media platform), but once I got going it wasn't bad at all. It was cool to see how quickly things can come together in Rails, as long as you have a sense of how to structure the data.

It was straightforward to set up different models for users, posts, comments, likes, etc. Probably the trickiest part was setting up the friend request system, where I ended up using separate models for friendships and friend requests. Not positive if that was the best/most efficient way to do it, but it works, and I'll keep my eyes open for other solutions in the future.

One of the extra credit requirements was to add polymorphism so that comments could be attached to either text posts, or photo posts. Adding polymorphism is simple enough, and makes sense as far as attaching comments to different types of objects... but I realized I couldn't find an elegant way to go down that route.

If photos and text posts are totally different objects, I'd need to have two separate forms for their creation - either just side-by-side, or somehow on different tabs, displayed via JS or something. It just felt like it was getting too complicated, and in checking other people's assignments, it looked like none of them (that I looked at, at least) ended up using polymorphism in the way described by the project. So instead, I simply added a `:picture` attachment to the posts, with a custom validation to ensure that either a file or text is present.

All in all, this was a good project, and despite it being The Odin Project's final Rails project, it certainly wasn't the most difficult one I've had to do. I chalk that up to Rails' functionality and flexibility, and my growing familiarity with it.

God bless.

-Niko Birbilis
