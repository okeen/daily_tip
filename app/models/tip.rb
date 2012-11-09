class Tip < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list, :links_attributes, :category_id

  acts_as_taggable

  paginates_per 20

  has_reputation :votes,
                 :source => :user

  has_many :links
  belongs_to :author, class_name: User
  belongs_to :category

  validates :title, :content, :author_id, presence: true

  accepts_nested_attributes_for :links

  scope :from_today, lambda {
    beginining_of_day = Date.today.beginning_of_day
    end_of_day = Date.today.end_of_day
    where("created_at between ? and ?", beginining_of_day, end_of_day )
  }

  scope :search, lambda {|query|
    search_term = "%#{query.downcase}%"
    where("lower(title) LIKE ? or lower(content) LIKE ?", search_term, search_term)
  }

  scope :by_date, order("created_at desc")

  scope :popular, lambda {
    select('tips.*, coalesce(value, 0) as votes').
    joins('left join rs_reputations on tips.id = rs_reputations.target_id').
    where("rs_reputations.target_type = 'Tip'").
    where("rs_reputations.reputation_name = 'votes'").
    where(rs_reputations: {active: true}).
    order('votes desc')
  }

  #def self.popular
  #  self.find_with_reputation(:votes, :all, order: "votes desc")
  #
  #end
end
