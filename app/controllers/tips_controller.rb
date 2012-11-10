class TipsController < InheritedResources::Base
  set_tab :tips
  set_tab :home, only: [:home]
  set_tab :new, only: [:new, :edit]

  custom_actions collection: :tagged

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :delete]
  before_filter :set_new_tab, only: :new
  before_filter :load_tags, only: [:index, :tagged, :popular, :categorized]
  before_filter :load_category, only: [:categorized]
  before_filter :load_evaluations, only: [:show]

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

  def popular
    @tips = Tip.popular.page(params[:page] || 1)
    render :index
  end

  def categorized
    @tips = @current_category.tips.page(params[:page] || 1)
    render "index"
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

  def load_category
    @current_category = Category.find_by_name params[:category]
  end

  def load_evaluations
    @evaluations = resource.evaluations
    @current_user_evaluation = @evaluations.where(source_id: current_user.id).first if current_user
  end
end
