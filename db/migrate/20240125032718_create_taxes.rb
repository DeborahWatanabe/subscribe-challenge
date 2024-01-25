# frozen_string_literal: true

class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.timestamps
      t.string :name
      t.float :rate
    end
  end
end
