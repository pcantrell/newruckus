class SignupsController < ApplicationController
  def show
    @signup = Signup.new
  end

  def create
    @signup = signup = Signup.new(signup_params)
    if signup.valid?
      mail = Mail.new do
        from     signup.email
        to       'paul@innig.net'
        subject  "Composer Night signup: #{signup.name}"
        body(
          signup.each_pair.map do |k,v|
            "#{k.upcase}: #{v}"
          end.join("\n\n")
        )
      end
      if Rails.env.production?
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

  class Signup < OpenStruct
    include ActiveModel::Validations

    validates_presence_of :name, :email
    validates :email, email: true, allow_blank: true
  end

end
