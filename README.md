Husky Code Challenge
===

## Getting started

To setup the project you'll need this following technology and version:

- Ruby - 2.5.3

Do not forget to install this package:

- libpq-dev
- `sudo apt-get install libpq-dev`

In the file config/database.yml change the username for the username that you use in your postgres database

    default: &default
        adapter: postgresql
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        timeout: 5000
        host: localhost
        username: postgres  <- HERE

Now you can just clone this project and run:
- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`
- `rails s`

The last command will run the server in: http://localhost:3000

API endpoints
---

**OBS: Remember to always use http://localhost:3000 and the complements below**

### GET /api/v1/customers/:customer_id/credit_cards/:credit_card_id/transactions

This endpoint will return all the credit_card transactions, something like that:

    {
      "data": [
        {
          "id": "6",
          "type": "transaction",
          "attributes": {
            "amount": 10000,
            "currency": "usd",
            "status": "paid"
          },
          "relationships": {
            "credit_card": {
              "data": {
                "id": "2",
                "type": "credit_card"
              }
            }
          }
        },
        {
          "id": "7",
          "type": "transaction",
          "attributes": {
            "amount": 20000,
            "currency": "usd",
            "status": "paid"
          },
          "relationships": {
            "credit_card": {
              "data": {
                "id": "2",
                "type": "credit_card"
              }
            }
          }
        }
      ]
    }

You also can filter the transactions adding in the parameter **?status** in the end, example:

**/api/v1/customers/:customer_id/credit_cards/:credit_card_id/transactions?status=dispute**

    {
      "data": [
        {
          "id": "19",
          "type": "transaction",
          "attributes": {
            "amount": 10000,
            "currency": "usd",
            "status": "dispute"
          },
          "relationships": {
            "credit_card": {
              "data": {
                "id": "2",
                "type": "credit_card"
              }
            }
          }
        },
        {
          "id": "20",
          "type": "transaction",
          "attributes": {
            "amount": 10000,
            "currency": "usd",
            "status": "dispute"
          },
          "relationships": {
            "credit_card": {
              "data": {
                "id": "2",
                "type": "credit_card"
              }
            }
          }
        }
      ]
    }

### PUT /api/v1/customers/:customer_id/credit_cards/:credit_card_id/transactions/:transaction_id/to_dispute

This endpoint will change the transaction to dispute if it is paid, returning:

    {
      "data": {
        "id": "21",
        "type": "transaction",
        "attributes": {
          "amount": 10000,
          "currency": "usd",
          "status": "dispute"
        },
        "relationships": {
          "credit_card": {
            "data": {
              "id": "1",
              "type": "credit_card"
            }
          }
        }
      }
    }

### PUT /api/v1/customers/:customer_id/credit_cards/:credit_card_id/transactions/:transaction_id/refund

This endpoint will change the transaction to refund, if it is in dispute, returning:

    {
      "data": {
        "id": "21",
        "type": "transaction",
        "attributes": {
          "amount": 10000,
          "currency": "usd",
          "status": "refunded"
        },
        "relationships": {
          "credit_card": {
            "data": {
              "id": "1",
              "type": "credit_card"
            }
          }
        }
      }
    }

### POST /api/v1/customers/:customer_id/credit_cards/:credit_card_id/charge

This endpoint will create a new transaction for the credit card, it will always return the transaction requested

Body request example:

    {
        "transaction": {
            "currency": "usd",
            "amount": "10000"
        }
    }

If the transaction amount is less than the credit card spent_limit, the transaction will be automatically paid:

    {
      "data": {
        "id": "22",
        "type": "transaction",
        "attributes": {
          "amount": 10000,
          "currency": "usd",
          "status": "paid"
        },
        "relationships": {
          "credit_card": {
            "data": {
              "id": "1",
              "type": "credit_card"
            }
          }
        }
      }
    }

If the transaction amount is greater than the credit card spent_limit, the transaction will be automatically failed:

    {
      "data": {
        "id": "23",
        "type": "transaction",
        "attributes": {
          "amount": 1000000,
          "currency": "usd",
          "status": "failed"
        },
        "relationships": {
          "credit_card": {
            "data": {
              "id": "1",
              "type": "credit_card"
            }
          }
        }
      }
    }

Unit tests
---

To execute the unit tests just run:
`rspec`

And all specs will be executed automatically.

The specs were made with Rspec gem.

Deployed app
---

You can access the deployed app with:
https://secure-castle-24407.herokuapp.com/api/v1/ + endpoint
