# frozen_string_literal: true

class CreateProductTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :product_taxes do |t|
      t.timestamps
      t.belongs_to :product
      t.belongs_to :tax
    end
  end
end
