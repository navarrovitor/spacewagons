class AddEqiuppedPriceToPart < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :is_equiped, :boolean
  end
end
