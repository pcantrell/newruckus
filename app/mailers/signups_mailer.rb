class SignupsMailer < ActionMailer::Base
  default from: "The New Ruckus <the@newruckus.org>", bcc: "paul@innig.net"

  def edit_info(signup, message_opts = {})
    @signup = signup
    @message_opts = message_opts
    
    signup_mail signup, subject: "Your Composer Night signup info" do |format|
      format.html do
        if signup.scheduled?
          render 'edit_upcoming'
        else
          render 'edit_unscheduled'
        end
      end
    end
  end

  helper do
    def info_attr_name(attr)
      I18n.t attr, scope: 'signup.attrs'
    end
  end

private

  def signup_mail(signup, opts, &block)
    mail opts.reverse_merge(to: "#{signup.presenter.name.inspect} <#{signup.presenter.email}>"), &block
  end
end
