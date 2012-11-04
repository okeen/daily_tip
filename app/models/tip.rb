class Tip < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list

  acts_as_taggable

  belongs_to :author, class_name: User

  validates :author_id, presence: true
end
