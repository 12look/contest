class AddAttachmentFileToWorks < ActiveRecord::Migration
  def self.up
    change_table :works do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :works, :file
  end
end
