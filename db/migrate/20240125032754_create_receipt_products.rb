# frozen_string_literal: true

class CreateReceiptProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipt_products do |t|
      t.timestamps
      t.belongs_to :receipt
      t.belongs_to :product
      t.integer :amount
      t.decimal :price, precision: 10, scale: 2
      t.decimal :tax, precision: 10, scale: 2
    end
  end
end
