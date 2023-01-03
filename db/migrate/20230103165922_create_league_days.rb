class CreateLeagueDays < ActiveRecord::Migration[7.0]
  def change
    create_table :league_days do |t|
      t.integer :day
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
