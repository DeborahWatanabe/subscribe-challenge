# frozen_string_literal: true

class Receipt < ApplicationRecord
  has_many :receipt_products, dependent: :destroy
end
