class Event < ActiveRecord::Base
  extend FriendlyId
  include Bootsy::Container
  friendly_id :title, use: :slugged
  after_create :send_event_email

  belongs_to :user
  scope :approved, -> { where status: 'approved'}
  scope :draft, -> { where status: 'draft'}
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
  
  def self.search_event(category, address)
    if category.present? && address.present?
      where(['category ILIKE ?', "%#{category}%"]).near(address, 20)
    elsif category.present?
      where(['category ILIKE ?', "%#{category}%"])
    elsif address.present?
      near(address, 30)
    else
      puts "Il n'y a pas encore d'événements pour votre recherche :)"
    end
  end

  def send_event_email
    UserMailer.new_event(self).deliver_now
  end
end
