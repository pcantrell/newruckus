class Signup < ActiveRecord::Base
  belongs_to :presenter, class: Person
  belongs_to :composer_night, touch: true
  has_many :preferences, class: SignupPreference, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :presenter, :preferences

  validates :presenter, presence: true

  attr_accessor :read_guidelines

  scope :active,      -> { where(active: true).order(:created_at) }
  scope :upcoming,    -> { active.where(composer_night: ComposerNight.upcoming).order('composer_nights.start_time') }
  scope :unscheduled, -> { active.where(composer_night: nil) }
  scope :in_queue,    -> { active.where(composer_night: ComposerNight.upcoming + [nil]) }

  before_save :populate_access_token

  after_create :subscribe_presenter_to_mailing_list

  def scheduled?
    composer_night_id?
  end

  def unscheduled?
    !scheduled?
  end

  def upcoming?
    composer_night.upcoming?
  end

  def past?
    composer_night.past?
  end

  def preference_for(composer_night)
    preferences.find_or_create_by!(composer_night: composer_night)
  end

  def instance_variable_default(var)
    result = instance_variable_get(var)
    unless result
      result = yield
      instance_variable_set(var, result)
    end
    result
  end

  def required_info
    @signup.required_info ||= {
      presenter_name: presenter.name,
      title:          title,
      performers:     performers,
      approx_length:  approx_length,
      special_needs:  special_needs
    }
  end

  def optional_info
    @signup.optional_info = {
      description:    description,
      presenter_url:  presenter.url,
      presenter_bio:  presenter.bio
    }
  end

  def required_info_missing
    @signup.required_info_missing ||= required_info.select { |k,v| v.blank? }
  end

  def optional_info_missing
    @signup.optional_info_missing ||= optional_info.select { |k,v| v.blank? }
  end

  def info_provided
    @signup.info_provided ||= required_info.merge(optional_info).reject { |k,v| v.blank? }
  end

  def subscribe_presenter_to_mailing_list
    Delayed::Job.enqueue SubscribeToMailingList.new(presenter)
  end

private

  def populate_access_token
    self.access_token ||= SecureRandom.urlsafe_base64(18)
  end
end
