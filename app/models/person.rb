class Person < ActiveRecord::Base
  validates :name, presence: true
  validates :email, email: true, uniqueness: true, unless: -> (p) { p.email.nil? }
  validates :url, url: true

  def name=(name)
    write_attribute :name, name
    self.name_for_searching = name.strip.gsub(/[^a-z]+/i, ' ').downcase if name
  end
end