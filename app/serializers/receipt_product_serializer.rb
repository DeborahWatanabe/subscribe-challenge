# frozen_string_literal: true

class ReceiptProductSerializer < ActiveModel::Serializer
  attributes :amount, :product_name, :total

  def product_name
    object.product.name
  end

  def total
    object.amount * (object.price + object.tax)
  end
end
