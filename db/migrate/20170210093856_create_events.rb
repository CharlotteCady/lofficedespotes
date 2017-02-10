class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :subscription_link
      t.date :date
      t.time :time
      t.integer :price
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :organiser
      t.string :website
      t.references :user, index: true, foreign_key: true
      t.text :category
      t.boolean :favorite
      t.string :status

      t.timestamps null: false
    end
  end
end
