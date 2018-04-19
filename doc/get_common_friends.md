# Get common friends

## What it does

Retrieve all common friends of specified users

## How to call

```
curl -X GET -H 'Content-Type:application/json' -d '{"friends":["a@b.com","b@a.com"]}' https://warm-island-18484.herokuapp.com/api/get_common_friends
```

## Expected result

If the users exist and they have some common friends, friends detail that resemble:

```{"success":true,"friends":["c@common.com"],"count":1}```

You may specify more than two emails

## Possible Error

If any of the emails is not found, the request will fail with:

```{"status":"not_found","error":"Couldn't find User","message":"Record not found"}```
