class AddAttachmentPicturecontent2ToRessources < ActiveRecord::Migration
  def self.up
    change_table :ressources do |t|
      t.attachment :picturecontent2
    end
  end

  def self.down
    remove_attachment :ressources, :picturecontent2
  end
end
