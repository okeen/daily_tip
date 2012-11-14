class SubscriptionsController < InheritedResources::Base
  set_tab :subscriptions
  before_filter :authenticate_user!

  def create
    @subscription = current_user.subscriptions.new params[:subscription]
    create! { [:user, :subscriptions] }
  end

  protected

  def collection
    @subscriptions||= end_of_association_chain.active
  end

  def begin_of_association_chain
    current_user
  end
end
