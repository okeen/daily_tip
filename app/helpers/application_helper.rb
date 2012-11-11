module ApplicationHelper

  def render_flash
    flash_class = {notice: "alert-success", alert: "alert-error", error: "alert-error"}
    logger.debug flash.inspect

    flash.map do |name, msg|
      content_tag :div,
                  class: "alert #{flash_class[name]}", 'data-alert' => 'true' do

        content = []
        content << link_to('&times;'.html_safe, '#', class: 'close', :"data-dismiss" => 'alert')
        content << msg
        content.join('').html_safe
      end
    end.join('').html_safe
  end

  # Provides a link styled as a button.
  #
  # @param [String] anchor The anchor for the link
  # @param [String] URL The address to link to
  # @param [Hash] options The options for link_to
  # @return [String] the link with the needed styles
  def button_link_to anchor, url, options = {}
    klazz = options.delete(:class)

    if klazz.present?
      options[:class] = "btn #{klazz}"
    else
      options[:class] = "btn"
    end

    link_to anchor, url, options
  end

  # Draws an icon which shows a popover on hover
  # @param [String] content The content of the popover
  # @param [String] title The title on the popover
  def popover_info_icon(content, title, options={})
    options[:placement]||= "right"
    formated_content = content_tag :div, simple_format(content), class: 'left'
    formated_title = content_tag :div, title, class: 'left'

    icon = content_tag :i, nil,
                       'class' => 'icon-info-sign',
                       'data-content' => "#{formated_content}",
                       'data-original-title' => "#{formated_title}",
                       'data-placement' => options[:placement],
                       'rel' => 'popover'
    icon
  end

  def content_with_icon(content, klazz, color = nil)
    icon_class = "icon-#{klazz}"
    icon_class << " icon-white" if color == :white
    icon = content_tag :i, nil, class: icon_class

    (icon + " #{content}".html_safe)
  end

  def page_title
    text = content_for(:title)
    return nil if text == "none"
    text = t("#{controller_name}.#{action_name}.title") if text.blank?
    content_tag(:h1, text, id: "#{controller_name}_#{action_name}_title", class: "page_title")
  end

  def category_link(category)
    active = @current_category == category ? "active" : ""
    subdomain = category.present? ? category.name : "www"
    content_tag_for :li, category, class: active do
      link_to t("categories.#{category.name}"), tips_url(subdomain: subdomain)
    end

  end
end
