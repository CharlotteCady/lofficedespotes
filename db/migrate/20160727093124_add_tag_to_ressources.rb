class AddTagToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :tag, :string
  end
end
