class RemoveManagerFieldFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :manager
  end
end
