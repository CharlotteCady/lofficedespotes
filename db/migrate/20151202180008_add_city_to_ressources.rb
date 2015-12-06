class AddCityToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :city, :string
  end
end
