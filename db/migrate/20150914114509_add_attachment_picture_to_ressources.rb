class AddAttachmentPictureToRessources < ActiveRecord::Migration
  def self.up
    change_table :ressources do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :ressources, :picture
  end
end
