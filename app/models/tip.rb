class Tip < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :author, class_name: User

  validates :author_id, presence: true
end
