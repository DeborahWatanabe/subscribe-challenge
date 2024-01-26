# frozen_string_literal: true

class ReceiptsController < ApplicationController
  def create
    receipt = Receipts::CreateUseCase.call(create_params[:products])

    render json: Receipt.includes(receipt_products: :product).find(receipt.id),
           status: :created
  end

  private

  def create_params
    params.permit(products: %i[id amount price])
  end
end
