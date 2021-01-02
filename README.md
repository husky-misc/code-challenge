[![Maintainability](https://api.codeclimate.com/v1/badges/73df109be0abfaf16d3a/maintainability)](https://codeclimate.com/github/willdowglas/code-challenge/maintainability)

# Credit Card Transaction API

This is my implementation of [this challenge](/CHALLENGE.md).

## Setup and Run
Must have `docker`, `docker-compose` and `git` installed.

In the terminal, run:

```
$ docker-compose build
```
```
$ docker-compose run web rails db:setup
```
```
$ docker-compose up
```

After that, check out the endpoints suggested in the challenge.

## Test Coverage
To run the test suite, run this command:

```
$ docker-compose run web rspec
```

Additionally, you can look at `coverage/index.html` to check the test coverage.
