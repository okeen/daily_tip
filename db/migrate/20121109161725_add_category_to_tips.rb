class AddCategoryToTips < ActiveRecord::Migration
  def up
    add_column :tips, :category_id, :integer

  end

  def down
    remove_column :categories, :category_id
  end
end
