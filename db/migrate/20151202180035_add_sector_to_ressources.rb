class AddSectorToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :sector, :string
  end
end
