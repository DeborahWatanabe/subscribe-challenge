# frozen_string_literal: true

describe Receipt do
  it { is_expected.to have_many(:receipt_products) }
end
