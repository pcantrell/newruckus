class Person < ActiveRecord::Base
  validates :name, presence: true
  validates :email, email: true, uniqueness: true, unless: -> (p) { p.email.nil? }
  validates :url, url: true

  has_many :signups, foreign_key: :presenter_id

  def name=(name)
    write_attribute :name, name
    self[:name_for_searching] = name.strip.gsub(/[^a-z]+/i, ' ').downcase
  end

  def first_name
    self[:first_name] || default_first_name
  end

  def default_first_name
    name.strip.split(/\s+/).first
  end

end
