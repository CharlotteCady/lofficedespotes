class AddAttachmentPicturecontent1ToRessources < ActiveRecord::Migration
  def self.up
    change_table :ressources do |t|
      t.attachment :picturecontent1
    end
  end

  def self.down
    remove_attachment :ressources, :picturecontent1
  end
end
