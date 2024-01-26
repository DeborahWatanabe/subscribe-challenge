# frozen_string_literal: true

module ReceiptProducts
  class CreateService < ApplicationService
    ROUNDING_VALUE = BigDecimal('0.05')

    def initialize(params)
      @params = params
    end

    def call
      ReceiptProduct.create!(
        receipt_id: @params[:receipt_id],
        product_id: @params[:product_id],
        amount: @params[:amount],
        price: @params[:price],
        tax: rounded_tax
      )
    end

    private

    def raw_tax
      Product.includes(:taxes).find(@params[:product_id]).taxes.sum(:rate) * BigDecimal(@params[:price])
    end

    # The rounding rules for sales tax are that for a tax rate of n%,
    # a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.
    def rounded_tax
      two_digit_tax = BigDecimal(raw_tax.ceil(2).to_s)
      diff_to_round = two_digit_tax % ROUNDING_VALUE

      diff_to_round.zero? ? two_digit_tax : two_digit_tax - diff_to_round + ROUNDING_VALUE
    end
  end
end
