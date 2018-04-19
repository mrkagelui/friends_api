# Get receivers

## What it does

Upon receiving a "sender" and "text", 

## How to call

```
curl -X POST -H 'Content-Type:application/json' -d '{"sender":"a@b.com","text":"hello blocker@test.com stranger@test.com!"}' https://warm-island-18484.herokuapp.com/api/get_receivers
```

## Expected result

If both users exist:

```{"success":true,"recipients":["c@common.com","stranger@test.com"]}```

## Possible Error

If the sender is not found, the request will fail with:

```{"status":"not_found","error":"Couldn't find User","message":"Record not found"}```