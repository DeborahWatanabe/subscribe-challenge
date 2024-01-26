# frozen_string_literal: true

describe ReceiptsController do
  describe 'create' do
    context 'when success' do
      let(:product) { create(:product) }
      let(:tax) { create(:tax, rate: 0.1) }
      let(:params) do
        {
          products: [
            {
              id: product.id,
              amount: 1,
              price: 10.0
            }
          ]
        }
      end

      before { create(:product_tax, tax:, product:) }

      it 'returns status created' do
        post(:create, params:)

        expect(response).to have_http_status(:created)
      end

      it 'returns a receipt with its products' do
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
                'product_name' => product.name,
                'total' => '11.0'
              }
            ]
          }
        )
      end
    end

    context 'input 1' do
      let(:book) { create(:product, name: 'book') }
      let(:music_cd) { create(:product, name: 'music CD') }
      let(:chocolate_bar) { create(:product, name: 'chocolate bar') }
      let(:basic_tax) { create(:tax, name: 'basic tax', rate: 0.1) }

      before do
        create(:product_tax, tax: basic_tax, product: music_cd)
      end

      it 'return output 1' do
        params = {
          products: [
            {
              id: book.id,
              amount: 2,
              price: 12.49
            },
            {
              id: music_cd.id,
              amount: 1,
              price: 14.99
            },
            {
              id: chocolate_bar.id,
              amount: 1,
              price: 0.85
            }
          ]
        }

        post(:create, params:)

        created_receipt = Receipt.last

        expect(response.parsed_body).to eq(
          {
            'id' => created_receipt.id,
            'total_taxes' => '1.5',
            'total' => '42.32',
            'receipt_products' => [
              {
                'amount' => 2,
                'product_name' => 'book',
                'total' => '24.98'
              },
              {
                'amount' => 1,
                'product_name' => 'music CD',
                'total' => '16.49'
              },
              {
                'amount' => 1,
                'product_name' => 'chocolate bar',
                'total' => '0.85'
              }
            ]
          }
        )
      end
    end

    context 'input 2' do
      let(:chocolate) { create(:product, name: 'imported box of chocolates') }
      let(:perfume) { create(:product, name: 'imported bottle of perfume') }
      let(:basic_tax) { create(:tax, name: 'basic tax', rate: 0.1) }
      let(:import_duty) { create(:tax, name: 'import duty', rate: 0.05) }

      before do
        create(:product_tax, tax: import_duty, product: chocolate)
        create(:product_tax, tax: import_duty, product: perfume)
        create(:product_tax, tax: basic_tax, product: perfume)
      end

      it 'return output 2' do
        params = {
          products: [
            {
              id: chocolate.id,
              amount: 1,
              price: 10.0
            },
            {
              id: perfume.id,
              amount: 1,
              price: 47.5
            }
          ]
        }

        post(:create, params:)

        created_receipt = Receipt.last

        expect(response.parsed_body).to eq(
          {
            'id' => created_receipt.id,
            'total_taxes' => '7.65',
            'total' => '65.15',
            'receipt_products' => [
              {
                'amount' => 1,
                'product_name' => 'imported box of chocolates',
                'total' => '10.5'
              },
              {
                'amount' => 1,
                'product_name' => 'imported bottle of perfume',
                'total' => '54.65'
              }
            ]
          }
        )
      end
    end

    context 'input 3' do
      let(:imported_perfume) { create(:product, name: 'imported bottle of perfume') }
      let(:perfume) { create(:product, name: 'bottle of perfume') }
      let(:pills) { create(:product, name: 'packet of headache pills') }
      let(:chocolates) { create(:product, name: 'imported boxes of chocolates') }

      before do
        basic_tax = create(:tax, name: 'basic tax', rate: 0.1)
        import_duty = create(:tax, name: 'import duty', rate: 0.05)
        create(:product_tax, tax: basic_tax, product: imported_perfume)
        create(:product_tax, tax: import_duty, product: imported_perfume)
        create(:product_tax, tax: basic_tax, product: perfume)
        create(:product_tax, tax: import_duty, product: chocolates)
      end

      it 'return output 3' do
        params = {
          products: [
            {
              id: imported_perfume.id,
              amount: 1,
              price: 27.99
            },
            {
              id: perfume.id,
              amount: 1,
              price: 18.99
            },
            {
              id: pills.id,
              amount: 1,
              price: 9.75
            },
            {
              id: chocolates.id,
              amount: 3,
              price: 11.25
            }
          ]
        }

        post(:create, params:)

        created_receipt = Receipt.last

        expect(response.parsed_body).to eq(
          {
            'id' => created_receipt.id,
            'total_taxes' => '7.9',
            'total' => '98.38',
            'receipt_products' => [
              {
                'amount' => 1,
                'product_name' => 'imported bottle of perfume',
                'total' => '32.19'
              },
              {
                'amount' => 1,
                'product_name' => 'bottle of perfume',
                'total' => '20.89'
              },
              {
                'amount' => 1,
                'product_name' => 'packet of headache pills',
                'total' => '9.75'
              },
              {
                'amount' => 3,
                'product_name' => 'imported boxes of chocolates',
                'total' => '35.55'
              }
            ]
          }
        )
      end
    end
  end
end
