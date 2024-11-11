class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :source_id
      t.string :source_type
      t.text :content

      t.timestamps
    end
  end
end
