class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.string :serial
      t.string :type
      t.integer :condition
      t.integer :price
      t.integer :stat_acc
      t.integer :stat_spd
      t.integer :stat_man
      t.integer :stat_atk
      t.integer :stat_def
      t.boolean :for_sale

      t.timestamps
    end
  end
end
