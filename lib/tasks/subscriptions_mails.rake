namespace :subscriptions do
  desc "Delivers the daily tip emails"
  task daily_tip: :environment  do
    Subscription.deliver_daily_tips!
  end
end
