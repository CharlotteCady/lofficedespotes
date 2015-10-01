class AddSeodescriptionToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :seodescription, :string
  end
end
