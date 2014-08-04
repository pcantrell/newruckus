module ApplicationHelper
  def hero(&block)
    @hero_count ||= 0
    @hero_count += 1
    content_tag(
      :header,
      capture(&block),
      class: 'hero',
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
end
