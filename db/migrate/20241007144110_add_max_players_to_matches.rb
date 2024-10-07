class AddMaxPlayersToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :max_players, :integer
  end
end
