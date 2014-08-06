module ApplicationHelper
  def hero(compaction: true, &block)
    @hero_count ||= 0
    @hero_count += 1
    content_tag(
      :header,
      capture(&block),
      class: 'hero ' + (compaction ? 'compaction' : ''),
      'data-stellar-background-ratio' => 0.5,
      'data-stellar-vertical-offset' => @hero_count * 300)
  end

  def social_icon_size
    32
  end

  def social_link(network, url)
    link_to url do
      image_tag "social-link-#{network}.png",
        alt: network.to_s.capitalize,
        width:  social_icon_size,
        height: social_icon_size
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
