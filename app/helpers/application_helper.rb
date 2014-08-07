module ApplicationHelper
  def hero(compaction: true, &block)
    content_tag(
      :header,
      capture(&block) +
        content_tag(:div, '', class: 'page-loading'),
      class: 'hero ' + (compaction ? 'compaction' : ''))
  end

  def social_link(network, url)
    link_to url do
      image_tag "social-link-#{network}.png", alt: network.to_s.capitalize, class: 'social-icon'
    end
  end

  def mailing_list_link(link_text, header: true, &block)
    popup_id = "mailing_list_popup_#{rand(10**10)}"
    link_to(link_text, 'http://eepurl.com/OdGZb', 'data-show-popup' => popup_id) +
      content_tag(:aside, class: 'popup', id: popup_id) do
        render 'shared/mailing_list_signup', header: header
      end
  end
end
