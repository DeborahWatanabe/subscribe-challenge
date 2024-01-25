# frozen_string_literal: true

describe Product do
  it { is_expected.to have_many(:product_taxes) }
  it { is_expected.to have_many(:receipt_products) }
end
