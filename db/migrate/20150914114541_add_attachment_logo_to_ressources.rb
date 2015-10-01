class AddAttachmentLogoToRessources < ActiveRecord::Migration
  def self.up
    change_table :ressources do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :ressources, :logo
  end
end
