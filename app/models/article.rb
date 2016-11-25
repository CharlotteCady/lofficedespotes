class Article < ActiveRecord::Base
  belongs_to :user
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  validates :seo_title, presence: true, uniqueness: true
  validates :seo_description, presence: true, uniqueness: true

  has_attached_file :picture,
  styles: { large: "900x900>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
  content_type: /\Aimage\/.*\z/

  def self.search_article(category)
    if category.present?
      where(['category ILIKE ?', "%#{category}%"])
    end
  end
end
