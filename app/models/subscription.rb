class Subscription < ActiveRecord::Base
  belongs_to :user
  attr_accessible :period, :tip_count, :tip_scope

  before_create :set_state

  scope :active, where(state: "active")

  POSSIBLE_STATES = %w(active canceled)
  PERIODS = %w(daily weekly)
  SCOPES = %w(popular random category)
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

  def self.deliver_daily_tips!
    Rails.logger.debug "Subscription#deliver_daily_tips! started at #{Time.now}"
    tip_to_send = Tip.from_today.first
    return if tip_to_send.blank?
    Rails.logger.debug "Tip found: #{tip_to_send.id}, delivering to subscribers..."
    Subscription.active.each do |subscription|
      begin
        user = subscription.user
        SubscriptionsMailer.daily_tip(tip_to_send, user).deliver
        Rails.logger.debug "\tDelivered to #{user.email}"
      rescue Exception=> e
        Rails.logger.debug "\tError! #{e.message}"
      end
    end
  end

  private

  def set_state
    self.state = "active"
  end
end
