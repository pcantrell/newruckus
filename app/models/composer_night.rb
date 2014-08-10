class ComposerNight < ActiveRecord::Base
  belongs_to :location
  has_many :composer_night_signups

  validates :start_time, presence: true
  validates :location, presence: true
  validates :slots, numericality: { only_integer: true, greater_than: 0 }

  def title
    start_time.strftime('%Y-%m-%d')
  end
end
