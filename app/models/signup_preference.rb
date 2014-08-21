class SignupPreference < ActiveRecord::Base
  VISIBLE_STATUSES = %w(no maybe yes).freeze
  STATUSES = (VISIBLE_STATUSES + ['unknown']).freeze

  belongs_to :signup
  belongs_to :composer_night

  validates :signup, presence: true
  validates :composer_night, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  before_validation do
    self.status ||= 'unknown'
  end
end
