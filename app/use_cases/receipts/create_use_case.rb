# frozen_string_literal: true

module Receipts
  class CreateUseCase < ApplicationUseCase
    def initialize(products)
      @products = products
    end

    def call
      ActiveRecord::Base.transaction do
        @receipt = Receipt.create
        create_receipt_products
        update_receipt_total
      end

      @receipt
    end

    private

    def create_receipt_products
      @products.each do |product|
        ReceiptProducts::CreateService.call(
          receipt_id: @receipt.id,
          product_id: product[:id],
          amount: product[:amount],
          price: product[:price]
        )
      end
    end

    def update_receipt_total
      Receipts::UpdateService.call(@receipt)
    end
  end
end
