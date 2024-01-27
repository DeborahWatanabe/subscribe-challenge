# Subscribe Code Challenge

Instructions: [challenge.md](https://github.com/DeborahWatanabe/subscribe-challenge/blob/main/challenge.md)

## Solution
* Language/Framework: Ruby on Rails
* `POST receipt/` - Receive the purchased products and return the calculated price and taxes.

## Installation

### Dependencies

* Ruby: 3.2.2
* Rails: 7.1.2
* Postgres: 14.10

### Instructions

* bundle
* bundle e rails db:create
* bundle e rails db:migrate
* bundle e rails db:migrate RAILS_ENV=test
* bundle e rspec

## How to test

Run the unit tests on `spec/controllers/receipts_controller_spec.rb`

```
bundle e rspec spec/controllers/receipts_controller_spec.rb
```