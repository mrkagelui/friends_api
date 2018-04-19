# Friends management API

A simple friends management API written in Ruby on Rails, which is a solution to an assessment

## Getting Started

### Prerequisites

```
git
Ruby (version 2.3.x)
Rails (version 5.1.6)
```

### Installing

Clone the repo

```
git clone git@github.com:mrkagelui/friends_api.git
```

Install gems

```
bundle
```

Database migration

```
rails db:migrate
```

Now you may deploy a local server with

```
rails s
```

and you may test with curl, such as:

```
curl -X POST -H 'Content-Type:application/json' -d '{"requestor":"a@b.com", "target":"b@a.com"}'  http://localhost:3000/api/follow
```

which will return

```
{"status":"not_found","error":"Couldn't find User","message":"Record not found"}
```

unless you do

```
curl -X POST -H 'Content-Type:application/json' -d '{"email":"a@b.com"}' http://localhost:3000/api/signup
curl -X POST -H 'Content-Type:application/json' -d '{"email":"b@a.com"}' http://localhost:3000/api/signup
```

## Running the tests

BDD (Behavior Driven Development) is used with rspec, run all the specs with

```
rspec
```

or run them individually under spec/ directory

## Deployment

On heroku, deploy with

```
heroku login
heroku keys:add (if you have never)
heroku create
git push heroku master
```

Currently, the app is deployed on https://warm-island-18484.herokuapp.com

## Versioning

Specify desired version in request header, such as `curl -X POST -H 'Accept:application/vnd.friends.v1'`, otherwise the default will be the latest version

## Endpoints

- [POST 'signup'](doc/signup.md)
- [POST 'add_friend'](doc/add_friend.md)
- [GET 'get_friends'](doc/get_friends.md)
- [GET 'get_common_friends'](doc/get_common_friends.md)
- [POST 'follow'](doc/follow.md)
- [POST 'block'](doc/block.md)
- [POST 'get_receivers'](doc/get_receivers.md)
