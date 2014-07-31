module ApplicationHelper
  def hero(&block)
    @hero_count ||= 0
    @hero_count += 1
    content_tag(
      :div,
      capture(&block),
      class: 'hero',
      'data-stellar-background-ratio' => 0.5,
      'data-stellar-vertical-offset' => @hero_count * 300)
  end
end
