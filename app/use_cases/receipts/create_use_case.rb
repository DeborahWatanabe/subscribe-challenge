# frozen_string_literal: true

module Receipts
  class CreateUseCase
    def initialize(products)
      @products = products
    end

    def call
      ActiveRecord::Base.transaction do
        receipt = Receipt.create()
        receipt_products = create_receipt_products

      end
    end

    private

    def create_receipt_products
      @products.map do |product|
        ReceiptProducts::CreateService.new(
          receipt_id: receipt.id,
          product_id: product[:id],
          amount: product[:amount],
          price: product[:price]
        ).call
      end
    end
  end
end
