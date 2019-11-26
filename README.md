# Bank Statement API

## API description

The application consists of an API that returns data about bank transactions such as: id, amount, credit card number, currency, installments, creation date and update date. In short, the API follows the business model: A **bank statement receipt** is made up of multiple transactions during a period. 

![Simplificated model](public/images/model.png)

All **bank statements receipt** created can be retrieved from the API via the `GET /v1/bank_statements` route. If we want to see a specific **receipt**, we access the `GET /v1/bank_statements/:id` route (for example, in the `GET /v1/bank_statements/22` route we can see transaction details of `id=22` in the database). Therefore, we may have multiple transactions for a specific period in one bank statement, just as we may have multiple bank statements of various specific time intervals. If we want to see the list of **transactions** in a specific **receipt**, we access the `GET /v1/bank_statements/:id/transactions` route (for example, in the `GET /v1/bank_statements/22/transactions` route we can see all transactions of the receipt with `id=22`).

Additionally, you can create, update, and remove transactions from the database. The major API routes are shown below.

![API routes](public/images/routes.png)

## Customized routes

## Authentication

We use **Devise Token Auth** as a plugin to control user authentication in the API. To create a user in the API, you must access the route: 

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

## Gems

* **rails ~> 5.2.2** (Rails Framework)
* **rails-i18n ~> 5.1** (Collecting Locale data for Ruby on Rails I18n)
* **puma ~> 3.11** (App server)
* **sqlite3** (Database for Active Record)
* **devise_token_auth** (Token based authentication for Rails JSON APIs)
* **versionist** (A plugin for versioning Rails based RESTful APIs)
* **redis ~> 4.0** (Open source in-memory data structure store)
* **hiredis** (Ruby wrapper for hiredis - hiredis-rb)
* **bootsnap >= 1.1.0** (Reduces boot times through caching)
* **rack-cors** (Handling Cross-Origin Resource Sharing - CORS, making cross-origin AJAX possible)
* **active_model_serializers ~> 0.10.0** (ActiveModel::Serializer implementation and Rails hooks)
* **foreman** (Manage Procfile-based applications)
* **kaminari** (A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps)
* **byebug** (Plugin to stop execution and get a debugger console)
* **faker** (A library for generating fake data)

## Build Setup

    # install dependencies
    bundle
    
    # generate data
    rails dev:setup

## Running the application

    # run application
    rails s -b localhost
