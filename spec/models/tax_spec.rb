# frozen_string_literal: true

describe Tax do
  it { is_expected.to have_many(:product_taxes) }
end
