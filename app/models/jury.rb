class Jury < ActiveRecord::Base
  has_one :user, as: :meta, dependent: :destroy

  validates :middle_name, :rank, :degree, presence: true

  validates :middle_name, :rank, :degree, length: { in: 3..100 }
end
