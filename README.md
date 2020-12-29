Husky technical test

Congratulations!

You received this repository because we liked your profile and decided to move forward to the tecnhical step of our hiring process. We believe that talk is cheap that is why we would like to see some code before a conversation. After you submit a new Pull Request, our team will perform a code review and schedule a call to discuss your technical decisions.

Note: This task should take no longer than 1-2 hours at the most to complete.

Task
1) Fork this repository.

2) Scaffold a simple Rails 6 web app that models a credit card transaction. JSON data structure below:
  {
    "id": 9923,
    "created": 1389618241,
    "status": "paid",
    "amount": 4900,
    "currency": "usd",
    "credit_card_id" : 1232212
  }
*Note: Amount is in USD, cents*

Create a Customer object with first and last name.

The Transaction object has a credit card foreign key (credit_card_id). 

The Credit card should be related to the Costumers trough a BankAccount. 

(Feel free to model these relations as you want, here is the step where we will test your design and OO skills.)


Seed 4 Customers into the system:
Customer 1: 
  First Name: Johny 
  Last Name: Flow

Customer 2: 
  First Name: Raj
  Last Name: Jamnis

Customer 3: 
  First Name: Andrew
  Last Name: Chung

Customer 4: 
  First Name: Mike
  Last Name: Smith


Seed 20 transactions (charges) into the system:
10 Should be successful transactions:
  - 5 Should be linked to Customer 1 Visa Credit Card
  - 3 Should be linked to Customer 2 Visa Credit Card
  - 1 Should be linked to Customer 3 MasterCard Credit Card
  - 1 Should be linked to Customer 4 Visa Credit Card

5 Should be transactions that failed:
  - 3 Should be linked to Customer 3 Mastercard Credit Card
  - 2 Should be linked to Customer 4 Visa Credit Card

5 should be disputed:
  - 3 should be linked to Customer 1 Visa Credit Card
  - 2 should be linked to customer 2 Visa Credit Card
  
##
Create a Visual Representation of Different Charges:
On the view that shows all charges (most likely the GET /charges route), create three lists with H1 headers.

List 1 - Header: Failed Charges
In this list set the background color of the rows to #FF0000 and list the Customers name, the charge amount and the date that the charge failed for each failed charge.

List 2 - Header: Disputed Charges
In this list set the background color of the rows to ##FF5400 and list the Customers name, the charge amount and the date that the charge was disputed for each disputed charge.

List 3 - Header: Successful Charges
In this list simply display all the charges that were succesful.

Business Rules and Unit Tests

Create the following rules and cover it with unit tests:
1) A transaction can't change from `paid` to `failed` or `paid` to `dispute`. Once it is `paid` the uniq state available to change is `refunded`.
2) A transaction wich is under dispute state can go to the status: `paid` or `failed`.
3) A transaction can be `refunded` only if it is `paid`
3) Once a transaction is in `disputed` state, the amount of the disputed transaction is not available on the costumer credit card limit.


Once Complete
Commit and Push your code to your new repository
Send us a pull request, we will review your code and get back to you
