class AddProfilToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profil, :string
  end
end
