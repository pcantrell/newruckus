class ComposerNight < ActiveRecord::Base
  belongs_to :location
  has_many :signups, -> { order(:created_at) }, class: Signup
  has_many :presenters, through: :signups, class: Person  # why is class needed?

  validates :start_time, presence: true
  validates :location, presence: true
  validates :slots, numericality: { only_integer: true, greater_than_or_equal: 0 }

  scope :visible, -> { where(visible: true) }
  scope :upcoming, -> { visible.where('start_time >= ?', 90.minutes.ago).order(:start_time) }

  def self.next
    upcoming.first
  end

  def title
    start_time.strftime('CN %Y–%m–%d')
  end

  def slots_open
    @slots_open ||= [slots - signups.count, 0].max
  end

  def full?
    slots_open == 0
  end

  def past?
    start_time < 60.minutes.ago
  end

  def upcoming?
    !past?
  end
end
