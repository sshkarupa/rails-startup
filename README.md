## Rails startup

Preparation of a new rails app for the development

### Set up development environment

Prepare vagarant
```
$ mkdir rails-startup && cd rails-startup
$ wget https://git.io/vyG7L
$ echo '2.4.0' >> .ruby-version
```

Then create a new tmuxinator project
```
$ tmuxinator new rails-startup
```
Simple config:  https://git.io/vyG7Y

And let's go
```
$ mux s rails-startup
$ vagrant up && vagrant ssh
```

### Generate rails app

Genarete rails app template
```
$ rails new rails-startup [--api] -T -B -d postgresql
```

Add some needed gems in Gemfile
```ruby
...
group :development do
  gem 'pry-rails'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'fuubar'
end
```
Then run bundle install
```
$ cd /vagarnt && bundle install
```

### Install and configure rspec
```
$ rails generate rspec:install
$ mkdir spec/support
$ touch spec/support/{factory_girl.rb,database_cleaner.rb,shoulda_matchers.rb}
$ touch spec/acceptance_helper.rb
```
See all configs here: https://git.io/vyG7s

### Initialize better_errors for development

Add to `config/environment/developmet.rb` the following line:
```
BetterErrors::Middleware.allow_ip! '0.0.0.0/0'
```

### Specify database.yml

```
$ cp config/database.yml config/database.yml.sample
$ cat << _EOF_ > db/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
  username: vagrant
  password: vagrant

development:
  <<: *default
  database: rails_startup_development
  host: localhost

test:
  <<: *default
  database: rails_startup_test
  host: localhost
_EOF_

```

### Fix code style
```
$ rubocop --auto-gen-config
$ echo 'inherit_from: .rubocop_todo.yml' >> .rubocop.yml
```

### Git init
```
$ git init
$ cat << _EOF_ >> .gitignore
.vagrant
.rubocop.yml
.rubocop_todo.yml
config/database.yml
_EOF_
```
