# frozen_string_literal: true

module Receipts
  class UpdateService
    def initialize(receipt)
      @receipt = receipt
    end

    def call
      @receipt.update!(
        total_taxes:,
        total:
      )
    end

    private

    def receipt_products
      @receipt_products ||= ReceiptProduct.where(receipt_id: @receipt.id)
    end

    def total_taxes
      @total_taxes ||= receipt_products.sum do |product|
        product.tax * product.amount
      end
    end

    def total
      total_price = receipt_products.sum do |product|
        product.price * product.amount
      end

      total_price + total_taxes
    end
  end
end
