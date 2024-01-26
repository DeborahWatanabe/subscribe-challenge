# frozen_string_literal: true

FactoryBot.define do
  factory :receipt do
    total_taxes { 0.0 }
    total { 0.0 }
  end
end
