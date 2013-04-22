class AddAttachmentAttachmentToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :videos, :attachment
  end
end
