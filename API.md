# Bank Statement API routes documentation

## Authentication

To create a user in the API, you must access the route:

`POST http://localhost:3000/auth`

using as headers
 `Accept: application/vnd.api+json`
 `Content-type: application/vnd.api+json`

In the request body, it is necessary to pass three parameters: **email**, **password**, **password_confirmation**. The request is made according to the example below.

`{"email": "mariana@bsi.ufla.br", "password": "12345678", "password_confirmation": "12345678"}`

The response should be as the example below:

```
{
    "status": "success",
    "data": {
        "uid": "mariana@bsi.ufla.br",
        "id": 1,
        "email": "mariana@bsi.ufla.br",
        "provider": "email",
        "allow_password_change": false,
        "name": null,
        "nickname": null,
        "image": null,
        "created_at": "2019-11-26T02:03:28.026Z",
        "updated_at": "2019-11-26T02:03:28.467Z",
        "type": "user"
    }
}
```
Note: In the current version, authentication is disabled.

## Bank Statements operations

## Transactions operations

