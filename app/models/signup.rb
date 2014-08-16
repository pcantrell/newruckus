class Signup < ActiveRecord::Base
  belongs_to :presenter, class: Person
  belongs_to :composer_night, touch: true
  has_many :preferences, class: SignupPreference, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :presenter

  validates :presenter, presence: true

  scope :active,   -> { where(active: true) }
  scope :in_queue, -> { active.where(composer_night_id: nil).order(:created_at) }

  def preference_for(composer_night)
    preferences.find_or_initialize_by(composer_night: composer_night)
  end

  attr_accessor :read_guidelines

  before_save do
    self.access_token ||= SecureRandom.urlsafe_base64(18)
  end
end
