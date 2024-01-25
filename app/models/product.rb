# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :product_taxes
  has_many :receipt_products
end
