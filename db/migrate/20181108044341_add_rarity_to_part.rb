class AddRarityToPart < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :rarity, :string
  end
end
