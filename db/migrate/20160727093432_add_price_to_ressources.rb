class AddPriceToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :price, :string
  end
end
