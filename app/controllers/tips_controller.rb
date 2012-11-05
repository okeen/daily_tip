class TipsController < InheritedResources::Base
  set_tab :tips
  before_filter :authenticate_user!, only: [:create, :update]

  def create
    @tip = current_user.tips.new params[:tip]
    create!
  end
end
