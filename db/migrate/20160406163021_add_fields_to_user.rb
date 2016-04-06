class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :institution, :string
    add_column :users, :manager, :string
  end
end
