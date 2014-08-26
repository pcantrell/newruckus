# Preview all emails at http://localhost:3000/rails/mailers/signups_mailer
class SignupsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/signups_mailer/after_create
  def after_create
    SignupsMailer.after_create
  end

  # Preview this email at http://localhost:3000/rails/mailers/signups_mailer/edit_link
  def edit_link
    SignupsMailer.edit_info
  end

end
