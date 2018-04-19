# Follow

## What it does

Let one user follow another

## How to call

```
curl -X POST -H 'Content-Type:application/json' -d '{"requestor":"a@b.com", "target":"b@a.com"}' https://warm-island-18484.herokuapp.com/api/follow
```

## Expected result

If both users exist:

```{"success":true}```

## Possible Error

If either of the email is not found, the request will fail with:

```{"status":"not_found","error":"Couldn't find User","message":"Record not found"}```

If the following relationship already exists, the request will fail with:

```{"status":"bad_request","error":"Validation failed: User where it is source has already been taken","message":"Invalid parameter"}```