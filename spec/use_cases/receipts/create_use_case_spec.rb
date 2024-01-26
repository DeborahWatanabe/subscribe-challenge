# frozen_string_literal: true

describe Receipts::CreateUseCase do
  describe '#call' do
    let(:first_product) { create(:product) }
    let(:second_product) { create(:product) }
    let(:products) do
      [
        { id: first_product.id, amount: 1, price: 10.0 },
        { id: second_product.id, amount: 2, price: 20.0 }
      ]
    end

    before do
      allow(ReceiptProducts::CreateService).to receive(:call)
      allow(Receipts::UpdateService).to receive(:call)
    end

    it 'creates a receipt' do
      expect { described_class.call(products) }
        .to change(Receipt, :count).by(1)
    end

    it 'returns the created receipt' do
      result = described_class.call(products)

      expect(result).to eq(Receipt.last)
    end

    it 'calls ReceiptProducts::CreateService for each product' do
      described_class.call(products)

      expect(ReceiptProducts::CreateService).to have_received(:call).with(
        receipt_id: Receipt.last.id,
        product_id: first_product.id,
        amount: 1,
        price: 10.0
      )
      expect(ReceiptProducts::CreateService).to have_received(:call).with(
        receipt_id: Receipt.last.id,
        product_id: second_product.id,
        amount: 2,
        price: 20.0
      )
    end

    it 'calls Receipts::UpdateService' do
      described_class.call(products)

      expect(Receipts::UpdateService).to have_received(:call).with(Receipt.last)
    end
  end
end
