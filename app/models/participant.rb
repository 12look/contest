class Participant < ActiveRecord::Base
  has_one :user, as: :meta, dependent: :destroy

  validates :manager, presence: true

  validates :manager, length: { in: 3..100 }
end
