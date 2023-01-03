class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.references :league_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
