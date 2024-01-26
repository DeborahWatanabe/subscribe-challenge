# frozen_string_literal: true

describe Receipts::UpdateService do
  describe '#call' do
    let(:receipt) { create(:receipt) }

    context 'when the receipt has one product' do
      it 'updates the receipt with product values' do
        create(:receipt_product, receipt:, amount: 1, price: 5.99, tax: 0.5)

        described_class.new(receipt).call

        expect(receipt.reload).to have_attributes(
          total_taxes: 0.5,
          total: 6.49
        )
      end
    end

    context 'when the receipt has many products' do
      it 'updates the receipt with summed values' do
        create(:receipt_product, receipt:, amount: 1, price: 5.99, tax: 0.5)
        create(:receipt_product, receipt:, amount: 3, price: 10.0, tax: 1.5)

        described_class.new(receipt).call

        expect(receipt.reload).to have_attributes(
          total_taxes: 5.0,
          total: 40.99
        )
      end
    end

    context 'when receipt does not have products' do
      it 'update the receipt with zero' do
        described_class.new(receipt).call

        expect(receipt.reload).to have_attributes(
          total_taxes: 0.0,
          total: 0.0
        )
      end
    end
  end
end
