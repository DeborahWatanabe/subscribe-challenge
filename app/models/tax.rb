# frozen_string_literal: true

class Tax < ApplicationRecord
  has_many :product_taxes
end
