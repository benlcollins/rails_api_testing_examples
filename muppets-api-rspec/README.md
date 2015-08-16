# Getting Started...

To follow along, you'll need to have Rails 4.x and PostgreSQL installed. If you do NOT have these tools available, then work with a partner who has them.

### 1. Clone

```
git clone https://github.com/gmac/muppets-api.git
```

Or, fork this repo and clone down your own copy.

### 2. Setup

```
cd muppets-api
bundle install

rake db:create
rake db:migrate
rake db:seed
```

### 3. Start

```
rails s
```

Then go to `localhost:3000/muppets`. Once you're up and running, take 15 minutes to review this application's Rails configuration with a partner. It should look very familiar... the existing routes, controllers, and views are structured as a boilerplate Rails CRUD application.
