# frozen_string_literal: true

FactoryBot.define do
  factory :product_tax do
    product
    tax
  end
end
