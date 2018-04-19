# Sign up

## What it does

Add an user to the database

## How to call

```
curl -X POST -H 'Content-Type:application/json' -d '{"email":"a@b.com"}' https://warm-island-18484.herokuapp.com/api/signup
```

## Expected result

User detail that resembles:

```{"id":1,"email":"a@b.com","created_at":"2018-04-19T02:35:14.824Z","updated_at":"2018-04-19T02:35:14.824Z"}```

## Possible Error

If the email is of invalid format, the request will fail with:

```{"status":"bad_request","error":"Validation failed: Email is invalid","message":"Invalid parameter"}```