class Event < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :subscription_link, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :category, presence: true
end
