class Link < ActiveRecord::Base
  belongs_to :tip
  attr_accessible :description, :url

  validates :url, presence: true

  def to_readable_article
    require 'readability'
    require 'open-uri'

    source = open(self.url).read
    Readability::Document.new(source, tags: ["h1", "h2", "h3", "h4", "h5", "h6", "p", "img", "a", "div"]).content
  end
end
