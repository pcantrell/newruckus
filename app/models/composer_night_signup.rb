class ComposerNightSignup < ActiveRecord::Base
  belongs_to :presenter, class: Person
  belongs_to :composer_night

  accepts_nested_attributes_for :presenter

  validates :presenter, presence: true

  scope :active, -> { where(active: true) }
  scope :queue,  -> { active.where(composer_night_id: nil).order(:created_at) }

  attr_accessor :read_guidelines
end
