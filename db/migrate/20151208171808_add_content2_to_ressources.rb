class AddContent2ToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :content2, :string
  end
end
