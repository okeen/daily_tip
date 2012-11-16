class SubscriptionsController < InheritedResources::Base
  set_tab :subscriptions
  before_filter :authenticate_user!

  def create
    create! { [:user, :subscriptions] }
  end

  def destroy
    destroy! { [:user, :subscriptions] }
  end

  protected

  def collection
    @subscriptions||= end_of_association_chain.active
  end

  def begin_of_association_chain
    current_user
  end
end
