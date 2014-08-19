class SignupsController < ApplicationController

  before_filter :find_signup_by_token, only: [:edit, :update]

  def new
    @signup = Signup.new
    @signup.presenter = Person.new
    render 'new'
  end

  def create
    Signup.transaction do
      presenter = Person.find_or_initialize_by(email: (presenter_params[:email] || '').downcase)
      existing = presenter.signups.in_queue.first
      if existing
        render 'already_in_queue'
        return
      end

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
        redirect_to edit_signup_path(token: signup.access_token, new: 1)
      else
        render :new
      end
    end
  end

  def send_edit_link
    render :edit_link_sent
  end

  def edit
    if !@signup.composer_night
      render 'choose_date'
    elsif !@signup.composer_night.past?
      render 'program_info'
    else
      render 'performance_past'
    end
  end

  def update
    raise 'not implemented'
  end

private

  def find_signup_by_token
    @signup = Signup.find_by!(access_token: params[:token])
  end

  def signup_params
    @signup_params ||= params.require(:signup).permit(:comments, :guidelines)
  end

  def presenter_params
    @presenter_params ||= params[:signup].require(:presenter_attributes).permit(:email, :name, :phone)
  end
  helper_method :presenter_params

end
