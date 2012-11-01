class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :title
      t.references :author

      t.text :content

      t.timestamps
    end
  end
end
