class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :work, index: true, foreign_key: true
      t.references :criterion, index: true, foreign_key: true
      t.integer :size
    end
  end
end
