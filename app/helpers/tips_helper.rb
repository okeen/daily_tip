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
    button_tag t("tips.reputation.#{vote.to_s}"), class: klazz,
               data: {target: tip_votes_path(tip, vote: vote.to_s)}
  end
end
