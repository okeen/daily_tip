class TipsController < InheritedResources::Base
  set_tab :home

  custom_actions collection: :tagged

  before_filter :authenticate_user!, only: [:create, :update]
  before_filter :set_new_tab, only: :new
  before_filter :load_tags, only: [:index, :tagged]

  has_scope :page, default: 1
  has_scope :order, default: "created_at DESC"
  has_scope :search, as: "q"

  def create
    @tip = current_user.tips.new params[:tip]
    create!
  end

  def tagged
    @tips = Tip.tagged_with(params[:tag]).by_date.page(params[:page] || 1)
    render :index
  end

  def home
    @tips = Tip.by_date.limit(10)
  end

  protected

  def set_new_tab
    set_tab [:new]
  end

  def load_tags
    @tags = Tip.tag_counts_on :tags
  end

end
