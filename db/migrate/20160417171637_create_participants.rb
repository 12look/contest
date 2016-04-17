class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :classroom
      t.string :manager
    end
  end
end
