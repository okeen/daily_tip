class SubscriptionsMailer < ActionMailer::Base
  default from: "tips@dailytip.com"

  def daily_tip(tip, user)
    @tip, @user = tip, user
    mail to: user.email
  end
end
