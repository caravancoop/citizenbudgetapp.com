# Citizen Budget

[![Dependency Status](https://gemnasium.com/opennorth/citizenbudgetapp.com.png)](https://gemnasium.com/opennorth/citizenbudgetapp.com)
[![Stories in Ready](https://badge.waffle.io/opennorth/citizenbudgetapp.com.png?label=ready&title=Ready)](https://waffle.io/opennorth/citizenbudgetapp.com)

[Citizen Budget](http://www.citizenbudget.com/) is an open-source online, interactive budget simulator. Cities use it to invite citizens to get involved in their budget process by submitting balanced budgets and defining local priorities.

[See the wiki](https://github.com/opennorth/citizenbudgetapp.com/wiki) for documentation.


# Dependencies

- Bower
- Node.js
- PostgreSQL >= 9.4.2
- Ruby 2.3.0
- Imagemagick

# Getting started

```bash
$ bundle install
$ bower install
```

Copy default environment variables and configure in .env.local:

```bash
$ cp .env.default .env.local && $EDITOR .env.local
```

Run database migrations and add sample data:

```bash
$ rake db:setup
```

Create an admin user:

```ruby
AdminUser.create(role: 'superuser', email: 'your@email.addr', password: 'yourpass')
```

Finally, launch with [Foreman](https://github.com/opennorth/citizenbudgetapp.com/blob/master/Procfile) and hit [localhost:3000](http://localhost:3000):

```bash
$ foreman start
```

# Development

## Docker

First, install [docker and docker-compose](https://docs.docker.com/mac/started/).

Configure environment variables in `.env.docker`:

```
RAILS_ENV=development
RACK_ENV=development

POSTGRESQL_DATABASE=postgres
POSTGRESQL_USERNAME=postgres
POSTGRESQL_PASSWORD=
POSTGRESQL_ADDRESS=db
```

Build the app image:

```bash
$ docker build -f Dockerfile.dev -t citizenbudget .
```

Load database schema and seeds:

```bash
$ docker-compose run web bundle exec rake db:schema:load
$ docker-compose run web bundle exec rake db:seed
```

Launch all services and hit [docker:3000](http://docker:3000):

```bash
$ docker-compose up
```

## Production

See documentation on [how to deploy in production](https://github.com/opennorth/citizenbudgetapp.com/wiki/Deployment).

Copyright (c) 2011-2014 Open North Inc., released under the GNU Affero General Public License, Version 3.
