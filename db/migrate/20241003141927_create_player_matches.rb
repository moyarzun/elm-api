class CreatePlayerMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :player_matches do |t|
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.jsonb :score, default: {}

      t.timestamps
    end
  end
end
