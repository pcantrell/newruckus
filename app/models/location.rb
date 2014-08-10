class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :url, url: true
end
