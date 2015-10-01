class AddSlugToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :slug, :string
  end
end
