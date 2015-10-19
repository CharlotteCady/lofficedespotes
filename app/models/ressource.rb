class Ressource < ActiveRecord::Base
  extend FriendlyId
  include Bootsy::Container
  friendly_id :title, use: :slugged

  acts_as_commentable
  acts_as_votable
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :subcategory, presence: true
  validates :website, presence: true
  validates :seotitle, presence: true, uniqueness: true
  validates :seodescription, presence: true, uniqueness: true
  # validates :slug, presence: true, uniqueness: true

  has_attached_file :picture,
      styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/

  has_attached_file :logo,
      styles: { thumb: "100x100>" }
  validates_attachment_content_type :logo,
      content_type: /\Aimage\/.*\z/

  def self.search(keyword, category, subcategory)
    if keyword.present? && category.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%", "#{subcategory}"])
    elsif keyword.present? && category.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%"])
    elsif category.present? && subcategory.present?
      where(['category ILIKE ? AND subcategory ILIKE ?', "%#{category}%", "#{subcategory}"])
    elsif keyword.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "#{subcategory}"])
    elsif keyword.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    elsif category.present?
      where(['category ILIKE ?', "%#{category}%"])
    elsif subcategory.present?
      where(['subcategory ILIKE ?', "%#{subcategory}%"])
    else
      puts "Il n'y a pas de résultats pour votre recherche :)"
    end
  end

  def score
    self.get_likes.size
  end
end
