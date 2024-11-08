class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :round, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.boolean :locked, default: false

      t.timestamps
    end
  end
end
