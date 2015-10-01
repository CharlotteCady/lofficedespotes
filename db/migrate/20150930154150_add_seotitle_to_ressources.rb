class AddSeotitleToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :seotitle, :string
  end
end
