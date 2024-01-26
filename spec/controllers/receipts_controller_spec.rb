# frozen_string_literal: true

describe ReceiptsController do
  describe 'create' do
    let(:product) { create(:product) }
    let(:tax) { create(:tax, rate: 0.1) }
    let!(:product_tax) { create(:product_tax, tax:, product:) }

    it 'returns a receipt with its products' do
      params = {
        products: [
          id: product.id,
          amount: 1,
          price: 10.0
        ]
      }

      post(:create, params:)

      created_receipt = Receipt.last

      expect(response.parsed_body).to eq(
        {
          'id' => created_receipt.id,
          'total_taxes' => '1.0',
          'total' => '11.0',
          'receipt_products' => [
            {
              'amount' => 1,
              'price' => '10.0',
              'tax' => '1.0',
              'product_name' => product.name
            }
          ]
        }
      )
    end
  end
end
