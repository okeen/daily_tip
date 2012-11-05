class Tip < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list, :links_attributes

  acts_as_taggable

  has_many :links
  belongs_to :author, class_name: User

  validates :title, :content, :author_id, presence: true

  accepts_nested_attributes_for :links
end
