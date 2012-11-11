class CategorizedTipsController < TipsController
  defaults :resource_class => Tip, :collection_name => 'tips', :instance_name => 'tip'

  before_filter :load_category

  protected

  def begin_of_association_chain
    @current_category
  end

  def load_category
    @current_category = Category.find_by_name request.subdomain
  end
end