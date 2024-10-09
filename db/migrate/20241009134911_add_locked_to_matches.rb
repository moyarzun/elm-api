class AddLockedToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :locked, :boolean, default: false
  end
end
