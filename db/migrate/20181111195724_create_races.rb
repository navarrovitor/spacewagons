class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :map
      t.integer :runners, array: true, default: []
      t.integer :champs_stats, array: true, default: []
      t.integer :final_results, array: true, default: []
      t.integer :runners_acc, array: true, default: []
      t.integer :runners_spd, array: true, default: []
      t.integer :runners_man, array: true, default: []
      t.integer :runners_atk, array: true, default: []
      t.integer :runners_def, array: true, default: []

      t.timestamps
    end
  end
end
