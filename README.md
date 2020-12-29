# Husky

Congratulations, you're almost there! 

You received this repository because we liked your profile and decided to move forward to the technical step of our hiring process. 

## Talk is cheap! 

That is why we would like to see some code before a conversation. 

After you submit a Pull Request, our team will perform a code review and schedule a call with you.

## Getting Started
We are going to build a Credit Card Transactions API.

 Our data modeling will follow something close to:
 - A Customer may have one or more credit cards through an Account. 
 - A Credit Card has a spent limit, the customer full_name, a number, an expiration date, CVV code and has many transactions.

## Tasks
Scaffold a simple Rails 6 API and models a Credit Card transaction. 

JSON data structure below:
```json
  {
    "id": 9923,
    "created": 1389618241,
    "status": "paid",
    "amount": 4900,
    "currency": "usd",
    "credit_card_id" : 1232211
  }
 ``` 

- To avoid monetary round issues, the amount field is always in USD cents
- A Transaction object has a credit card foreign key (credit_card_id). 
- A transaction status could be `failed`, `paid`, `dispute`, `refunded`
- The Credit card should be related to a Customer through an Account. 

> Feel free to model these relations as you want, here is the step where we will test your design and Object-Oriented Programming (SOLID, Design, Clean Code) skills. Models Objects are not only a representation of the database table, you can have objects at /models dir that are not ActiveRecord models (Concerns, UseCases, Services, etc).

## API Endpoints

##### Create an API endpoint where I can return all transactions of a Customer credit card
This endpoint should respect the rules bellow 
- return json as the default result
- paginate results automatically and return only 5 transactions per page
- accepts query parameters as filters for transactions statuses. For example:
```localhost:3000/api/v1/customer/{id}/credit_card/{id}/transactions?status=failed```

The endpoint should receive nested attributes to support the /GET method similar to: 
```localhost:3000/api/v1/customer/{id}/credit_card/{id}/transactions```

##### Create an API endpoint where we can charge a Customer credit card
The endpoint should receive a body containing the `currency` and `amount` attributes and support nested attributes on the /POST method
```localhost:3000/api/v1/customer/{id}/credit_card/{id}/charge```

## Business Rules and Unit Tests

Create a State Machine and unit tests to cover the following business rules:
1) A transaction status can't change from `paid` to `failed`. 
2) A `paid` transaction can change only to `refunded` or `dispute`.
2) A transaction can be `refunded` only if it is in a `dispute`
3) A transaction under dispute state can go to the status: `paid` or `refunded`.
4) A Transaction will be automatically `failed` if the credit card does not have limit available.
5) Once a transaction is in a `disputed` state, the amount of the disputed transaction is not available on the Customer credit card limit.

*You don't need to build a State Machine from the ground. If you don't know what a state machine is, please have a look at https://github.com/aasm/aasm or a similar project*

## Seeds

Seed 4 Customers into the system:
```
Customer 1: 
  First Name: Yukihiro 
  Last Name: Matsumoto

Customer 2: 
  First Name: Sandi
  Last Name: Matz

Customer 3: 
  First Name: Martin
  Last Name: Fowler

Customer 4: 
  First Name: Dr. Alan
  Last Name: Kay
```

Seed 20 transactions (charges) into the system

- 10 Should be successful transactions:
```
  - 5 Should be linked to Customer 1 Visa Credit Card
  - 3 Should be linked to Customer 2 Visa Credit Card
  - 1 Should be linked to Customer 3 MasterCard Credit Card
  - 1 Should be linked to Customer 4 Visa Credit Card
```
- 5 Should be transactions that failed transactions:
```
  - 3 Should be linked to Customer 3 Mastercard Credit Card
  - 2 Should be linked to Customer 4 Visa Credit Card
```

- 5 should be disputed transactions:
```
  - 3 should be linked to Customer 1 Visa Credit Card
  - 2 should be linked to customer 2 Visa Credit Card
 ```
## Once Complete
1) Commit and Push your code to your forked
2) Send us a pull request, we will review your code and get back to you.

## Questions
If you have any question regarding the project, you can contact us directly by email
