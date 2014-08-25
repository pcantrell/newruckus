module ApplicationHelper
  def hero(compaction: true, &block)
    content_tag(
      :header,
      capture(&block) +
        content_tag(:div, '', class: 'page-loading'),
      class: 'hero ' + (compaction ? 'compaction' : ''))
  end

  def social_link(network, url)
    link_to network.to_s.capitalize, url, class: "social-icon #{network}"
  end

  def mailing_list_link(link_text, header: true, &block)
    popup_id = "mailing_list_popup_#{rand(10**10)}"
    link_to(link_text, '//newruckus.us2.list-manage.com/subscribe?u=a9c460563163a39349a209835&id=0df09dc73b', 'data-show-popup' => popup_id) +
      content_tag(:aside, class: 'popup', id: popup_id) do
        render 'shared/mailing_list_signup', header: header
      end
  end

  GREETINGS = [
      "Greetings",
      "Ahoy",
      "Howdy",
      "Well met",
      "G’day",
      "Hi there",
      "Hiya",
      "Namaste",
      "Aloha",
      "Cheerio",
      "Ciao",
  ].freeze

  def random_greeting
    GREETINGS.sample
  end
end
