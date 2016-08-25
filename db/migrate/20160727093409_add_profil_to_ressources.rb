class AddProfilToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :profil, :string
  end
end
