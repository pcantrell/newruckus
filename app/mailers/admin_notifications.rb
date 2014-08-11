class AdminNotifications < ActionMailer::Base
  default from: "the@newruckus.org", to: "paul@innig.net"

  def signup(signup, changed_attrs)
    @signup = signup
    @changed_attrs = changed_attrs

    mail from: signup.presenter.email,
         subject: "Composer Night signup: #{signup.presenter.name}"
  end
end
