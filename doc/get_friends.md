# Get friends

## What it does

Retrieve all friends of an existing user

## How to call

```
curl -X GET -H 'Content-Type:application/json' -d '{"email":"a@b.com"}' https://warm-island-18484.herokuapp.com/api/get_friends
```

## Expected result

If the user exist, friends detail that resemble:

```{"success":true,"friends":["b@a.com"],"count":1}```

## Possible Error

If the email is not found, the request will fail with:

```{"status":"not_found","error":"Couldn't find User","message":"Record not found"}```
