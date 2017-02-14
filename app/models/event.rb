class Event < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  validates :title, presence: true
  validates :description, presence: true
  validates :subscription_link, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :category, presence: true
  validates :organiser, presence: true

end
