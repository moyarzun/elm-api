class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :scoring_type
      t.integer :players_per_match, default: 2, null: false

      t.timestamps
    end
  end
end
