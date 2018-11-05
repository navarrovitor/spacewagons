class AddStarterToPart < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :is_starter, :boolean
  end
end
