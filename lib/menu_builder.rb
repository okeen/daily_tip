class MenuBuilder < TabsOnRails::Tabs::TabsBuilder
  def tab_for(tab, options, item_options = {})
    name = I18n.t "menu.#{tab}"
    item_options[:class] = (current_tab?(tab) ? 'active' : '')

    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end
end
