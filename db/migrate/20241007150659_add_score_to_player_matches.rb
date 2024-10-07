class AddScoreToPlayerMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :player_matches, :score, :integer
  end
end
