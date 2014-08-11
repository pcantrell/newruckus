class ComposerNight < ActiveRecord::Base
  belongs_to :location
  has_many :signups, class: ComposerNightSignup
  has_many :presenters, through: :signups, class: Person  # why is class needed?

  validates :start_time, presence: true
  validates :location, presence: true
  validates :slots, numericality: { only_integer: true, greater_than: 0 }

  scope :upcoming, -> { where('start_time >= ?', 90.minutes.ago).order(:start_time) }

  def self.next
    upcoming.first
  end

  def title
    start_time.strftime('%Y-%-m-%d')
  end

  def slots_open
    [slots - presenters.count, 0].max
  end

  def full?
    slots_open == 0
  end
end
