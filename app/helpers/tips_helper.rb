module TipsHelper
  def tip_tag_list_for(tip)
    tags = tip.tag_list.map do |tag|
      link_to tag, tagged_tips_path(tag), class: "tag badge"
    end.join.html_safe
    unless tags.blank?
      content_with_icon("", "tags") + tags
    else
      ""
    end
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

  def tip_vote_buttons_for(tip, evaluation)
    positive_vote_exists = evaluation.present? && evaluation.value > 0
    negative_vote_exists = evaluation.present? && evaluation.value < 0
    [
       vote_button_for(tip, :up, positive_vote_exists),
       vote_button_for(tip, :down, negative_vote_exists)

    ].join.html_safe
  end

  def vote_button_for(tip, vote, active = false)
    klazz = "vote_button btn btn-small "
    popularity_class = vote == :up ? "popularity_positive " : "popularity_negative "
    klazz << popularity_class
    klazz << "active" if active

    button_id = popularity_class.strip

    icon = content_with_icon("", "thumbs-#{vote}")

    button_tag icon, class: klazz, id: button_id,
               data: {target: tip_votes_path(tip, vote: vote.to_s)}
  end

  def tip_category_breadcrumb category
    content_tag :li do
      link_to t("categories.#{category.name}"), [:tips], class: "tip_category_link"
    end
  end

  def tip_normalized_reputation_class(tip)
    reputation = tip.normalized_reputation_for(:votes)
    if reputation > 0.75
      "badge badge-success"
    elsif reputation > 0.5
      "badge badge-info"
    elsif reputation > 0.25
      "badge badge-warning"
    else
      "badge badge-important"
    end
  end
end
