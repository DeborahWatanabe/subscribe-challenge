# frozen_string_literal: true

describe ProductTax do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:tax) }
end
