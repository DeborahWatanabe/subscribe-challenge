# frozen_string_literal: true

describe ReceiptProducts::CreateService do
  describe '.call' do
    let(:receipt) { create(:receipt) }
    let(:tax) { create(:tax, rate: 0.1) }
    let(:product_tax) { create(:product_tax, tax:) }

    it 'creates a ReceiptProduct' do
      params = {
        receipt_id: receipt.id,
        product_id: product_tax.product_id,
        amount: '1',
        price: '10.0'
      }

      expect { described_class.call(params) }
        .to change(ReceiptProduct, :count).by(1)
      expect(ReceiptProduct.last).to have_attributes(
        receipt_id: receipt.id,
        product_id: product_tax.product_id,
        amount: 1,
        price: 10.0,
        tax: 1.0
      )
    end
  end

  describe 'tax rounding rule' do
    let(:receipt) { create(:receipt) }
    let(:tax) { create(:tax, rate: 0.099) }
    let(:product_tax) { create(:product_tax, tax:) }

    context 'when the tax last digit is below 0.05' do
      it 'rounds up to 0.05' do
        params = {
          receipt_id: receipt.id,
          product_id: product_tax.product_id,
          amount: '1',
          price: '10.2'
        }

        result = described_class.call(params)

        # raw_tax = 1.0098, rounded_tax = 1.05
        expect(result.tax).to eq(1.05)
      end
    end

    context 'when the tax last digit is above 0.05' do
      it 'rounds up to 0.1' do
        params = {
          receipt_id: receipt.id,
          product_id: product_tax.product_id,
          amount: '1',
          price: '10.9'
        }

        result = described_class.call(params)

        # raw_tax = 1.0791, rounded_tax = 1.10
        expect(result.tax).to eq(1.1)
      end
    end

    context 'when the tax is a multiple of 0.05' do
      let(:tax) { create(:tax, rate: 0.05) }

      it 'does not round' do
        params = {
          receipt_id: receipt.id,
          product_id: product_tax.product_id,
          amount: '1',
          price: '10.0'
        }

        result = described_class.call(params)

        # raw_tax = 0.5, rounded_tax = 0.5
        expect(result.tax).to eq(0.5)
      end
    end
  end
end
