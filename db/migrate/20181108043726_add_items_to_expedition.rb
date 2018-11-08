class AddItemsToExpedition < ActiveRecord::Migration[5.2]
  def change
    add_column :expeditions, :expedition_item_1, :integer
    add_column :expeditions, :expedition_item_2, :integer
    add_column :expeditions, :expedition_item_3, :integer
  end
end
