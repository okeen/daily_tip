class TipsController < InheritedResources::Base
  set_tab :home
  before_filter :authenticate_user!, only: [:create, :update]
  before_filter :set_new_tab, only: :new

  has_scope :page, default: 1
  has_scope :order, default: "created_at DESC"
  has_scope :search, as: "q"

  def create
    @tip = current_user.tips.new params[:tip]
    create!
  end

  protected

  def set_new_tab
    set_tab [:new]
  end

end
