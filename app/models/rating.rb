class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :work
  belongs_to :criterion

  validates :size, numericality: { only_integer: true, greater_than: 0, less_than: 11 }

  scope :was_rait, ->(work, user) { where("user_id=?", user.id).where("work_id=?", work.id) }
end