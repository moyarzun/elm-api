class CreatePlayerMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :player_matches do |t|
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
