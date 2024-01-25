# frozen_string_literal: true

class ReceiptProduct < ApplicationRecord
  belongs_to :receipt
  belongs_to :product
end
