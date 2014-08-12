class SignupsController < ApplicationController

  def show
    @signup = Signup.new
    @signup.presenter = Person.new
  end

  def create
    Signup.transaction do
      presenter_params = params[:signup][:presenter_attributes]
      presenter = Person.find_or_initialize_by(email: (presenter_params[:email] || '').downcase)
      %i(name phone).each do |attr|
        val = presenter_params[attr]
        presenter.send "#{attr}=", val unless val.blank?
      end

      @signup = signup = Signup.new(signup_params)
      signup.presenter = presenter

      changed_attrs = []
      %w(name phone).map do |attr|
        old_val = @signup.presenter.send("#{attr}_was")
        if @signup.presenter.send("#{attr}_changed?") && !old_val.blank?
          changed_attrs << [attr, old_val]
        end
      end

      if presenter.save && signup.save
        AdminNotifications.signup(signup, Hash[changed_attrs]).deliver
        render :success
      else
        render :show
      end
    end
  end

  def edit
    #TODO: check access token
  end

  def update
    raise 'not implemented'
  end

private

  def signup_params
    params.require(:signup).permit(:comments, :guidelines)
  end

  def presenter_params
    params[:signup].require(:presenter_attributes).permit(:email, :name, :phone)
  end

end
