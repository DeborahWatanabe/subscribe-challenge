# frozen_string_literal: true

class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :total_taxes, :total

  has_many :receipt_products
end
