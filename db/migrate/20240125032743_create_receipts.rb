# frozen_string_literal: true

class CreateReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|
      t.timestamps
      t.decimal :total_taxes, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
    end
  end
end
