class AddArchiveUrlToWorks < ActiveRecord::Migration
  def change
    add_column :works, :archive_url, :string
  end
end
