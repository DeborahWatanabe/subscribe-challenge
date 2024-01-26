# frozen_string_literal: true

FactoryBot.define do
  factory :receipt_product do
    receipt
    product
    amount { rand(1..10) }
    price { 5.99 }
    tax { 0.5 }
  end
end
