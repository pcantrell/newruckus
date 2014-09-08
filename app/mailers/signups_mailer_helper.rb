module SignupsMailerHelper
  def info_attr_name(attr)
    I18n.t attr, scope: 'signup.attrs'
  end

  def apply_substitutions(text)
    text.gsub(/%([A-Z0-9_]+)%/i) do
      case $1.downcase
        when 'first_name'
          @signup.presenter.first_name
        else
          raise SubstitutionError.new("Unknown substitution: #{$1}")
      end
    end
  end

  def format_message_fragment(text)
    apply_substitutions(text).
      strip.
      split(/[\n\r]+/).
      map do |para|
        "<p>#{para}</p>"  # NB: embedded HTML supported!
      end.
      join.
      html_safe
  end

  class SubstitutionError < Exception
  end
end
