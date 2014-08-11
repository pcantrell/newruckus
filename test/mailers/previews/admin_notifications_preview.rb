# Preview all emails at http://localhost:3000/rails/mailers/admin_notifications
class AdminNotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_notifications/signup
  def signup
    AdminNotifications.signup
  end

end
