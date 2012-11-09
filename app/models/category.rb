class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :lft, :name, :parent_id, :rgt

  CATEGORIES = {
      technology: [:programming, :gadgets],
      music: [:instruments, :theory],
      health: [:diet, :beauty, :exercise],
  }
  has_many :tips

  def self.load_categories!
    CATEGORIES.each do |category_name, subcategories|
      parent_category = Category.create name: category_name.to_s
      subcategories.each do |subcategory_name|
        Category.create name: subcategory_name, parent_id: parent_category.id
      end
    end
  end

  def self.recursive_list
    Category.roots.map{|category| [category, category.children]}.flatten
  end

  def localized_name
    padding_text = self.parent.present? ? "  " : ""
    padding_text + I18n.t("categories.#{self.name}")
  end
end
