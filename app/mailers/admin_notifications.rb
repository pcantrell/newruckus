class AdminNotifications < ActionMailer::Base
  default from: "the@newruckus.org", to: "paul@innig.net"

  def signup(signup, new_signup, changed_attrs = {})
    @signup = signup
    @changed_attrs = changed_attrs

    mail from: signup.presenter.email,
         to: ["paul@innig.net"],
         subject: "Composer Night #{new_signup ? 'new signup' : 'info changed'}: #{signup.presenter.name}"
  end

  def spam_filtered(attributes)
    @attrs = attributes

    mail to: ["paul@innig.net"],
         subject: "Composer Night spam filtered"
  end

  def info_summary(event, recipient_ids, comments)
    @event = event
    @comments = comments
    mail to: AdminUser.find(recipient_ids).map(&:email),
         subject: "Composer Night info for #{event.start_time.strftime('%b')}"
  end
end
