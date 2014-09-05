class SignupsController < ApplicationController

  before_action :find_signup_by_token, only: [:edit, :update]
  around_action :wrap_in_transaction

  def new
    @signup = Signup.new
    @signup.presenter = Person.new
    render 'new'
  end

  def create
    presenter = Person.find_or_initialize_by(email: (presenter_params[:email] || '').downcase)
    existing = presenter.signups.in_queue.first
    if existing
      render 'already_in_queue'
      return
    end

    presenter.name  = presenter_params[:name]  || presenter.name
    presenter.phone = presenter_params[:phone] || presenter.phone

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
      AdminNotifications.delay.signup(signup, Hash[changed_attrs])
      SignupsMailer.delay.touch_base(signup)
      flash[:success] = "Composer Night signup created"
      redirect_to edit_signup_path(token: signup.access_token, new: 1)
    else
      flash[:error] = "Unable to create Composer Night signup. Please correct the errors below."
      render :new
    end
  end

  def send_edit_link
    presenter = Person.find_by!(email: params[:email])
    signup = presenter.signups.in_queue.first

    SignupsMailer.delay.touch_base(signup)
    render :edit_link_sent
  end

  def edit
    if @signup.unscheduled?
      @signup_prefs = ComposerNight.upcoming.reject(&:full?).map do |event|
        @signup.preference_for(event)
      end

      render 'choose_date'
    elsif @signup.upcoming?
      render 'program_info'
    else
      render 'performance_past'
    end
  end

  def update
    success =
      @signup.update(signup_params) &&
      @signup.presenter.update(presenter_params)
    
    if success
      flash[:success] = "Signup information updated"
    else
      flash[:error] = "Unable to update information. Please correct the problems below."
    end

    edit
  end

private

  def find_signup_by_token
    @signup = Signup.find_by!(access_token: params[:token])
  end

  def signup_params
    @signup_params ||=
      params.require(:signup).permit(
        :comments, :guidelines, :title, :performers, :approx_length, :description, :special_needs,
        preferences_attributes: [:id, :status])
  end

  def presenter_params
    @presenter_params ||= if params[:signup][:presenter_attributes]
      params[:signup].require(:presenter_attributes).permit(:email, :name, :phone, :url, :bio)
    else
      {}
    end
  end
  helper_method :presenter_params

  def wrap_in_transaction(&block)
    Signup.transaction(&block)
  end

end
