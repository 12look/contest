class AddTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :isvideo, :boolean, :default => false
  end
end
