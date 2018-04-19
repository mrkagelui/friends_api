# Add friend

## What it does

Add a friend relationship for two existing users

## How to call

```
curl -X POST -H 'Content-Type:application/json' -d '{"friends":["a@b.com","b@a.com"]}' https://warm-island-18484.herokuapp.com/api/add_friend
```

## Expected result

If both users exist:

```{"success":true}```

## Possible Error

If either of the email is not found, the request will fail with:

```{"status":"not_found","error":"Couldn't find User","message":"Record not found"}```

If more than two emails are supplied, only the first two will be processed

If the friendship already exists, the request will fail with:

```{"status":"bad_request","error":"Validation failed: User where it is user1 has already been taken","message":"Invalid parameter"}```

If one of the users is blocking another, this will fail with:

```{"status":"bad_request","error":"one of the users is blocking another","message":"Friendship not added"}```