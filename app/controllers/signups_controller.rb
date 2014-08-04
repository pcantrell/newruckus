class SignupsController < ApplicationController
  def show
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)
    if @signup.valid?
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
