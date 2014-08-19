module SignupsHelper
  def event_time(format)
    @signup.composer_night.start_time.strftime(format)
  end

  def semantic_form_for_signup(&block)
    semantic_form_for @signup, url: edit_signup_path(token: @signup.access_token), &block
  end
end
