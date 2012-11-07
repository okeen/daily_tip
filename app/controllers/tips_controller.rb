class TipsController < InheritedResources::Base
  set_tab :home
  before_filter :authenticate_user!, only: [:create, :update]
  before_filter :set_new_tab, only: :new

  def create
    @tip = current_user.tips.new params[:tip]
    create!
  end

  private

  def set_new_tab
    set_tab [:new]
  end
end
