# Newsroom

A simple cloud news reader for those that like to host their own.

* * *
![Story Detail](http://i.imgur.com/PDpubTf.png)
* * *
![Index](http://i.imgur.com/MR6IRzK.png)
* * *

## Installation Instructions

The app configuration assumes you are using PostgreSQL.

Create a config/secrets.yml file and set the following config variables for your environment:

```
    production (or development/test):
      secret_key_base: <secret key to sign cookies>
      db_name: <db name>
      db_user: <db user>
      db_password: <db password>
```


...then...


```
    $ bundle install

    $ bundle exec rake db:migrate
```

To run locally:


```
  $ bundle exec rails server
```

... And if you would like feeds to automatically be fetched (without you having to click the "refresh" button in-page), set up a cron job that runs the **fetch_feeds** rake task.

## VPS/Dedicated Server

To run Newsroom on a VPS or dedicated server, I recommend using [Phusion Passenger](https://www.phusionpassenger.com/). Because this is a very straightforward and idiomatic Rails application with no arcane dependencies it is relatively easy to set up with the standard Passenger configuration.

Note that the production configuration uses memcached heavily. You will want to make sure to install memcached on your VPS or dedicated server to maximize performance. The configuration in config/environments/production.rb assumes the default memcached host/port (localhost:11211).

### Thanks
This project borrows some code from the [Stringer](https://github.com/swanson/stringer) app. It was initially conceived as a performance-oriented re-implementation of Stringer in idiomatic Rails. It has deviated enough from Stringer that that is no longer a helpful way to frame the project.