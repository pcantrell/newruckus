class SignupPreference < ActiveRecord::Base
  STATUSES = %w(no maybe yes).freeze

  belongs_to :signup
  belongs_to :composer_night

  validates :signup, presence: true
  validates :composer_night, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
