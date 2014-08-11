class ComposerNightSignup < ActiveRecord::Base
  belongs_to :presenter, class: Person
  belongs_to :composer_night

  validates :presenter, presence: true

  scope :active, -> { where(active: true) }
  scope :queue,  -> { active.where(composer_night_id: nil).order(:created_at) }
end
