class CreateJuries < ActiveRecord::Migration
  def change
    create_table :juries do |t|
      t.string :middle_name
      t.string :rank
      t.string :degree
    end
  end
end
