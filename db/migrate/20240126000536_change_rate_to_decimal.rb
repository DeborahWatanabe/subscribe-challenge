# frozen_string_literal: true

class ChangeRateToDecimal < ActiveRecord::Migration[7.1]
  def up
    change_column :taxes, :rate, :decimal, precision: 10, scale: 6
  end

  def down
    change_column :taxes, :rate, :float
  end
end
