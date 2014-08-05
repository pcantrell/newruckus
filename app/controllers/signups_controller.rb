class SignupsController < ApplicationController
  def show
    @signup = Signup.new
  end

  def create
    @signup = signup = Signup.new(signup_params)
    if signup.save
      mail = Mail.new do
        from     signup.email
        to       'paul@innig.net'
        subject  "Composer Night signup: #{signup.name}"
        body(
          %w(name email comments phone guidelines).map do |k|
            "#{k.upcase}: #{signup[k]}"
          end.join("\n\n")
        )
      end
      if Rails.env.production?
        mail.delivery_method.settings[:enable_starttls_auto] = false
        mail.deliver!
      else
        puts
        puts mail
        puts
      end

      render :success
    else
      render :show
    end
  end

private

  def signup_params
    params.require(:signup).permit(:name, :email, :comments, :phone, :guidelines)
  end

end
