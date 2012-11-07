module TipsHelper
  def tip_tag_list_for(tip)
    tip.tag_list.map do |tag|
      link_to tag, tagged_tips_path(tag), class: "tag badge"
    end.join.html_safe
  end

  def tip_link(link)
    icon = "search"
    content = content_with_icon link.url, icon
    link_to raw(content), link.url, class: "tip_link btn-link span9"
  end

  def tag_cloud_classes
    %w(tag_level1 tag_level2 tag_level3 tag_level4)
  end

  def link_to_tag_tips tag, options = {}
    klazz = options[:class]
    klazz << " tag_cloud_tag"
    link_to tag, tagged_tips_path(tag.name), options.merge(class: klazz)
  end
end
