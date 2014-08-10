class ComposerNightSignup < ActiveRecord::Base
  belongs_to :person
  belongs_to :composer_night

  validates :person, presence: true
end
