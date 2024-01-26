# frozen_string_literal: true

class ReceiptProductSerializer < ActiveModel::Serializer
  attributes :amount, :price, :tax, :product_name

  def product_name
    object.product.name
  end
end
