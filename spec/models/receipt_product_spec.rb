# frozen_string_literal: true

describe ReceiptProduct do
  it { is_expected.to belong_to(:receipt) }
  it { is_expected.to belong_to(:product) }
end
