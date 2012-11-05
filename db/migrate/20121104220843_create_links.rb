class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :tip
      t.string :url
      t.string :link_type
      t.text :description

      t.timestamps
    end
    add_index :links, :tip_id
  end
end
