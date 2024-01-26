# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :product_taxes, dependent: :destroy
  has_many :receipt_products, dependent: :restrict_with_exception
  has_many :taxes, through: :product_taxes
end
