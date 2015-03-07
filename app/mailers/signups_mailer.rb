class SignupsMailer < ActionMailer::Base
  default from: "The New Ruckus <the@newruckus.org>", bcc: "paul@innig.net"

  def touch_base(signup, message_opts = {})
    @signup = signup
    @opts = message_opts

    subject = @opts[:subject] || "Your Composer Night signup info"

    signup_mail signup, subject: apply_substitutions(subject) do |format|
      format.html do
        if @opts[:body]
          render html: format_message_fragment(@opts[:body]), layout: 'signups_mailer'
        elsif signup.scheduled?
          render 'edit_upcoming'
        else
          render 'edit_unscheduled'
        end
      end
    end
  end

  include SignupsMailerHelper
  helper  SignupsMailerHelper

private

  def signup_mail(signup, opts, &block)
    mail opts.reverse_merge(to: "#{signup.presenter.name.inspect} <#{signup.presenter.email}>"), &block
  end
end
