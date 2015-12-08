class AddContent3ToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :content3, :string
  end
end
