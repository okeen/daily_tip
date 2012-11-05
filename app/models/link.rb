class Link < ActiveRecord::Base
  belongs_to :tip
  attr_accessible :description, :link_type, :url

  validates :url, presence: true
end
