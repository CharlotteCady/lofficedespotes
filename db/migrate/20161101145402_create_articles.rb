class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.string :seo_title
      t.string :seo_description
      t.text :category
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
