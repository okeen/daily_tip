module SubscriptionsHelper

  def subscription_tip_scopes
    scopes = ["all", Category.roots.map(&:name)].flatten
  end

  def subscription_tip_counts
    Subscription.COUNTS
  end

  def tip_scope_collection_select(form)
    form.input :tip_scope, collection: subscription_tip_scopes,
               label_method: lambda{|scope| t("subscriptions.scoped.#{scope}")},
               value_method: lambda{|scope| scope },
               include_blank: false, required: false
  end

  def tip_period_collection_select(form)
    form.input :period, collection: Subscription.PERIODS,
               label_method: lambda{|period| t("subscriptions.period.#{period}")},
               value_method: lambda{|period| period },
               include_blank: false, required: false
  end
end
