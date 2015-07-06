# TODO Lite #

Lightweight REST API for managing TODO lists. This is a Rack application using Grape, ActiveRecord (without rails), and SQLite.

### Running the app ###

* `bundle exec rake db:migrate`
* `bundle exec rackup`

By default the server runs in development. To run in production, set the RACK_ENV variable:  `export RACK_ENV=production`

### Running the tests ###

* `bundle exec rake db:migrate`
* `bundle exec rspec spec`