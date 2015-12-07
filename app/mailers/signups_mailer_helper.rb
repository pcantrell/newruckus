module SignupsMailerHelper
  def self.available_substitutions
    available_substitutions_from_methods +
    available_substitutions_from_partials
  end

  def info_attr_name(attr)
    I18n.t attr, scope: 'signup.attrs'
  end

  def apply_substitutions(text)
    text.gsub(/%([A-Z0-9_]+)%/i) do
      sub_name = $1.downcase
      sub_method = "#{sub_name}_substitution"
      if respond_to?(sub_method)
        send(sub_method)
      else
        begin
          render partial: "signups_mailer/#{sub_name}"
        rescue ActionView::MissingTemplate
          raise SubstitutionError.new("Unknown substitution: #{$1}")
        end
      end
    end
  end

  def first_name_substitution
    @signup.presenter.first_name
  end

  def unknown_prefs_substitution
    sub_error = ->(msg) do
      raise SubstitutionError.new(
        "Cannot use %UNKNOWN_PREFS% for Signup##{@signup.id} (#{@signup.presenter.name}): #{msg}")
    end
    sub_error.call "already scheduled" if @signup.scheduled?
    
    unknown = @signup.preferences_for_upcoming.select { |p| p.status == 'unknown' }
    sub_error.call "no unknown dates" if unknown.empty?

    unknown.map { |pref| pref.composer_night.start_time.strftime('%b') }.to_sentence
  end

  def format_message_fragment(text)
    apply_substitutions(
        text.
        strip.
        split(/[\n\r]+/).
        map do |para|
          "<p>#{para}</p>\n\n"  # NB: embedded HTML supported!
        end.
        join).
      html_safe
  end

  class SubstitutionError < Exception
  end

private

  def self.available_substitutions_from_methods
    instance_methods.map { |m| $1 if m.to_s =~ /(.*)_substitution$/ }.reject(&:nil?)
  end

  def self.available_substitutions_from_partials
    Dir[Rails.root.join('app', 'views', 'signups_mailer', '_*')].map do |path|
      path.gsub(/.*\/_(.*)\.html\.haml$/, '\1')
    end
  end
end
