module SubscriptionsHelper
  def subscription_periods
    Subscription.PERIODS.each do |period|
      [period, I18n.t("subscriptions.periods.#{period}")]
    end
  end

  def subscription_tip_scopes
    Subscription.SCOPES.each do |scope|
      [ I18n.t("subscriptions.periods.#{scope}"), scope]
    end
  end

  def subscription_tip_counts
    Subscription.COUNTS
  end
end
