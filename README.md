
![](https://img.shields.io/github/stars/la-ruby/silica.svg) ![](https://img.shields.io/github/forks/la-ruby/silica.svg) ![](https://img.shields.io/github/issues/la-ruby/silica.svg)



### First time setup

```
$ git clone https://github.com/la-ruby/silica.git
Cloning into 'silica'...
remote: Enumerating objects: 631, done.
remote: Counting objects: 100% (631/631), done.
remote: Compressing objects: 100% (533/533), done.
remote: Total 631 (delta 69), reused 631 (delta 69), pack-reused 0
Receiving objects: 100% (631/631), 1.37 MiB | 2.10 MiB/s, done.
Resolving deltas: 100% (69/69), done.
```




Prerequisites:

```
$ brew install postgresql
$ brew install redis
$ brew install rbenv
$ rbenv install 3.x.x
```


```
$ cd silica
$ ./bin/setup
== Installing dependencies ==
https://github.com/rails/rails.git (at 7-0-stable@6a0f6c4) is not yet checked out. Run `bundle install` first.
Fetching https://github.com/rails/rails.git
Fetching gem metadata from https://rubygems.org/..........
Fetching https://github.com/hotwired/turbo-rails.git
Fetching https://github.com/heartcombo/devise
Fetching https://github.com/varvet/pundit
Fetching https://github.com/bullet-train-co/nice_partials
Fetching https://github.com/kaminari/kaminari
Fetching https://github.com/thoughtbot/factory_bot_rails
Fetching https://github.com/faker-ruby/faker
Fetching https://github.com/y-yagi/minitest-test_profile
Fetching https://github.com/bblimke/webmock
Fetching https://github.com/vcr/vcr
Fetching https://github.com/Rykian/clockwork
Fetching https://github.com/huacnlee/rails-settings-cached
...
Installing sassc-rails 2.1.2
Bundle complete! 36 Gemfile dependencies, 124 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.

== Preparing database ==
Created database 'apollo_development'
Created database 'apollo_test'

== Removing old logs and tempfiles ==

== Restarting application server ==
$ 
```

Run the tests


```
$ COVERAGE=1 PARALLEL_WORKERS=1 ./bin/rails test

# Running tests with run options --seed 12345:

...........................................................................................................................................

Finished tests in 9.352455s, 14.8624 tests/s, 14.9693 assertions/s.


139 tests, 140 assertions, 0 failures, 0 errors, 0 skips
Coverage report generated for tests to /Users/administrator/silica/coverage. 1535 / 1535 LOC (100.0%) covered.
$
```


Start a development instance

```
$ ./bin/rails s
=> Booting Puma
=> Rails 7.0.0 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.2 (ruby 3.0.3-p157) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 66771
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```




Add a /etc/hosts entries

```
127.0.0.1       backend.silica.com
127.0.0.1       portal.mysilicaoffer.com
127.0.0.1       app.silicamarket.io
```


(optional) Get a copy of development bucket from a senior developer, place it at ~/silica-bucket/

```
$ cd ~/silica-bucket
$ python -m SimpleHTTPServer 5000
```


Create an admin user

```
$ echo 'User.create!(email: "testing.developer.1@example.com", password
: "password")' | ./bin/rails console
```


```
$ open http://backend.silica.com:3000/projects

```


___


## Maintenance

### Upgrading rails

```
$ ./bin/rails --version  # check current version
Rails 7.0.0
$ git remote add upstream git@github.com:la-ruby/created-rails-app.git
$ git fetch upstream
remote: Enumerating objects: 313, done.
remote: Counting objects: 100% (313/313), done.
remote: Compressing objects: 100% (179/179), done.
remote: Total 285 (delta 151), reused 230 (delta 96), pack-reused 0
Receiving objects: 100% (285/285), 1.38 MiB | 2.43 MiB/s, done.
Resolving deltas: 100% (151/151), completed with 19 local objects.
From github.com:la-ruby/created-rails-app
 * [new branch]      main       -> upstream/main
$ git merge upstream/latest --allow-unrelated-histories
$ ./bin/rails --version
Rails 7.0.1
```

### Upgrading bootstrap

Copy over `bootstrap.css` and `bootstrap.bundle.js` after running `npm run dist` on your fork of twbs/bootstrap




___


## Coding guidelines

* Start PR with "WIP" in the title (and remove it when ready for review)
* Name your branch `your-nickname/task-id-task-title-kebab-cased


