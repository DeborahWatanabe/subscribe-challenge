# frozen_string_literal: true

FactoryBot.define do
  factory :tax do
    name { 'tax name' }
    rate { rand.round(2) }
  end
end
