class ChangeRateToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :taxes, :rate, :decimal, precision: 10, scale: 6
  end
end
