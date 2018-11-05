class AddStarterPriceToPart < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :initial_price, :integer
  end
end
