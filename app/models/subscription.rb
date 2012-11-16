class Subscription < ActiveRecord::Base
  belongs_to :user
  attr_accessible :period, :tip_count, :tip_scope

  before_create :set_state

  scope :active, where(state: "active")

  POSSIBLE_STATES = %w(active canceled)
  PERIODS = %w(daily weekly)
  SCOPES = %w(all category)
  COUNTS = [1, 10, 25]

  def self.PERIODS
    PERIODS
  end

  def self.SCOPES
    SCOPES
  end

  def self.COUNTS
    COUNTS
  end

  scope :daily, where(period: "daily")
  scope :weekly, where(period: "weekly")

  def self.deliver_daily_tips!
    Rails.logger.info "Subscription#deliver_daily_tips! started at #{Time.now}"
    Subscription.daily.active.each do |subscription|
      tips_to_send = subscription.pick_todays_tips
      Rails.logger.debug "\tSubscription##{subscription.id}, Tips found: #{tips_to_send.map &:id}"
      user = subscription.user
      #begin
      SubscriptionsMailer.daily_tip(tips_to_send, user).deliver
      Rails.logger.debug "\tDelivered to #{user.email}"
      #rescue Exception=> e
      #  Rails.logger.warn "\tError! #{e.message}"
      #end
    end
  end

  def self.deliver_weekly_tips!
    Rails.logger.info "Subscription#deliver_weekly_tips! started at #{Time.now}"
    Subscription.weekly.active.each do |subscription|
      tips_to_send = subscription.pick_week_tips
      Rails.logger.debug "\tSubscription##{subscription.id}, Tips found: #{tips_to_send.map &:id}"
      user = subscription.user
      #begin
      SubscriptionsMailer.weekly_tip(tips_to_send, user).deliver
      Rails.logger.debug "\tDelivered to #{user.email}"
      #rescue Exception=> e
      #  Rails.logger.warn "\tError! #{e.message}"
      #end
    end
  end

  def pick_todays_tips
    subscription_scoped_tips.created_the_last_24_hours.limit(self.tip_count).all
  end

  def pick_week_tips
    subscription_scoped_tips.created_the_last_week.limit(self.tip_count).all
  end

  private

  def subscription_scoped_tips
    if self.tip_scope == "all"
      Tip.popular
    else
      category = Category.find_by_name self.tip_scope
      category.present? ? category.tips.popular : Tip.popular
    end
  end

  def set_state
    self.state = "active"
  end
end
