class CreateRessources < ActiveRecord::Migration
  def change
    create_table :ressources do |t|
      t.string :title
      t.string :description
      t.string :content
      t.string :website
      t.string :address
      t.string :witness
      t.text :category
      t.text :subcategory
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
