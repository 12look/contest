class AddAttachmentVideoToWorks < ActiveRecord::Migration
  def self.up
    change_table :works do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :works, :video
  end
end
