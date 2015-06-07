class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
