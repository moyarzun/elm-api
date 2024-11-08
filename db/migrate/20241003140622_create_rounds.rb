class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds do |t|
      t.references :tournament, null: true, foreign_key: true

      t.timestamps
    end
  end
end
