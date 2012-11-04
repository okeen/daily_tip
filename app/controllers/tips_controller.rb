class TipsController < InheritedResources::Base
  set_tab :tips
  before_filter :authenticate_user!, only: [:create, :update]

  def create
    @tip = Tip.new params[:tip]
    @tip.author = current_user
    create!
  end
end
