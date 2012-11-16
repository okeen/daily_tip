class SubscriptionsMailer < ActionMailer::Base
  default from: "tips@dailytip.com"

  def daily_tip(tips, user)
    @tips, @user = tips, user
    mail to: user.email, subject: t("mailers.subscriptions.daily.subject")
  end

  def weekly_tip(tips, user)
    @tips, @user = tips, user
    mail to: user.email, subject: t("mailers.subscriptions.weekly.subject")
  end
end
