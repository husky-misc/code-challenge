# Bank Statement API

## API description

The application consists of an API that returns data about bank transactions such as: id, amount, credit card number, currency, installments, creation date and update date.

In short, the API follows the business model: A bank statement is made up of multiple transactions during a period. It can be retrieved from the API via the `GET /transactions` route. If we want to see a specific transaction, we access the `GET /transactions/:id` route (for example, in the `GET /transactions/26` route we can see transaction details of `id=26` in the database). Therefore, we may have multiple transactions for a specific period in one bank statement, just as we may have multiple bank statements of various specific time intervals.

![Simplificated model](public/images/model.png)

Additionally, you can create, update, and remove transactions from the database. The major API routes are shown below.

![API routes](public/images/routes.png)

## Customized routes

## Build Setup

    # install dependencies
    bundle
    
    # generate data
    rails dev:setup

## Running the application

    # run application
    rails s -b localhost
