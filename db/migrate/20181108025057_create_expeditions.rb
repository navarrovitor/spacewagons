class CreateExpeditions < ActiveRecord::Migration[5.2]
  def change
    create_table :expeditions do |t|
      t.string :destination
      t.string :date
      t.integer :gold_found
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
