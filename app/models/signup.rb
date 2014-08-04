class Signup < ActiveRecord::Base
  validates_presence_of :name, :email
  validates :email, email: true, allow_blank: true
end
