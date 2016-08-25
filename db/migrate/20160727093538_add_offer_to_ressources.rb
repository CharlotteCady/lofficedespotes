class AddOfferToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :offer, :string
  end
end
