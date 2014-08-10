class ComposerNight < ActiveRecord::Base
  validates :start_time, presence: true
  validates :location, presence: true
  validates :slots, numericality: { only_integer: true, greater_than: 0 }
end
