class ComposerNightSignup < ActiveRecord::Base
  validates :person, presence: true
end
