class AddTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :isvideo, :boolean, :default => 0
  end
end
