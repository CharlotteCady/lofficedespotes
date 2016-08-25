class Ressource < ActiveRecord::Base
  extend FriendlyId
  include Bootsy::Container
  friendly_id :title, use: :slugged
  # :use => [:slugged, :finders]
  # serialize :category, Array


  # before_save do
  #   self.category.gsub!(/[\[\]\"]/, "") if attribute_present?("category")
  # end

  acts_as_commentable
  acts_as_votable
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :tag, presence: true
  validates :profil, presence: true
  validates :price, presence: true
  validates :subcategory, presence: true
  validates :seotitle, presence: true, uniqueness: true
  validates :seodescription, presence: true, uniqueness: true
  # validates :slug, presence: true, uniqueness: true

  has_attached_file :picture,
      styles: { large: "900x900>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/

  has_attached_file :logo,
      styles: { thumb: "100x100>" }
  validates_attachment_content_type :logo,
      content_type: /\Aimage\/.*\z/

  has_attached_file :picturecontent1,
      styles: { large: "900x900>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/

  has_attached_file :picturecontent2,
      styles: { large: "900x900>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/

  def self.search(category, subcategory, profil, keyword)
    if keyword.present? && category.present? && subcategory.present? && profil.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ? AND subcategory ILIKE ? AND profil ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%", "%#{subcategory}%", "%#{profil}%"])
    elsif keyword.present? && category.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%", "%#{subcategory}%"])
    elsif keyword.present? && category.present? && profil.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ? AND profil ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%", "%#{profil}%"])
    elsif keyword.present? && profil.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND profil ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{profil}%", "%#{subcategory}%"])
    elsif profil.present? && category.present? && subcategory.present?
      where(['profil ILIKE ? AND category ILIKE ? AND subcategory ILIKE ?', "%#{profil}%", "%#{category}%", "%#{subcategory}%"])
    elsif keyword.present? && category.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND category ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{category}%"])
    elsif category.present? && subcategory.present?
      where(['category ILIKE ? AND subcategory ILIKE ?', "%#{category}%", "%#{subcategory}%"])
    elsif category.present? && profil.present?
      where(['category ILIKE ? AND profil ILIKE ?', "%#{category}%", "%#{profil}%"])
    elsif keyword.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{subcategory}%"])
    elsif keyword.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    elsif category.present?
      where(['category ILIKE ?', "%#{category}%"])
    elsif subcategory.present?
      where(['subcategory ILIKE ?', "%#{subcategory}%"])
    elsif profil.present?
      where(['profil ILIKE ?', "%#{profil}%"])
    else
      puts "Il n'y a pas de résultats pour votre recherche :)"
    end
  end

  def self.search_index(keyword, subcategory, profil)
    if keyword.present? && subcategory.present? && profil.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND subcategory ILIKE ? AND profil ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{subcategory}%", "%#{profil}%"])
    elsif keyword.present? && subcategory.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND subcategory ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{subcategory}%"])
    elsif subcategory.present? && profil.present?
      where(['subcategory ILIKE ? AND profil ILIKE ?', "%#{subcategory}%", "%#{profil}%"])
    elsif keyword.present? && profil.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ? AND profil ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{profil}%"])
    elsif keyword.present?
      where(['title ILIKE ? OR content ILIKE ? OR description ILIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    elsif subcategory.present?
      where(['subcategory ILIKE ?', "%#{subcategory}%"])
    elsif profil.present?
      where(['profil ILIKE ?', "%#{profil}%"])
    else
      puts "Il n'y a pas de résultats pour votre recherche :)"
    end
  end

  def self.search_by_category(category)
    if category.present?
      where(['category ILIKE ?', "%#{category}%"])
    else
      puts "Il n'y a pas encore d'article correspondant à votre recherche, dites-nous ce que vous aimeriez trouver :)"
    end
  end

  def self.search_by_tag(tag)
    if tag.present?
      where(['tag ILIKE ?', "%#{tag}%"])
    else
      puts "Il n'y a pas encore d'article correspondant à votre recherche, dites-nous ce que vous aimeriez trouver :)"
    end
  end

  def score
    self.get_likes.size
  end

  def self.highest_voted
    self.order("cached_votes_score DESC")
  end
end
