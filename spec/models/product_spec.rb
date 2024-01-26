# frozen_string_literal: true

describe Product do
  it { is_expected.to have_many(:product_taxes) }
  it { is_expected.to have_many(:receipt_products) }
  it { is_expected.to have_many(:taxes).through(:product_taxes) }
end
