class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :works, dependent: :destroy
  has_many :ratings, dependent: :destroy

  belongs_to :meta, polymorphic: true, dependent: :destroy

  validates :first_name, :last_name, :institution, presence: true

  validates :first_name, length: { in: 2..30 }
  validates :last_name, length: { in: 2..50 }
  validates :institution, length: { in: 3..100 }

  after_create :assign_default_role

  def assign_default_role
    add_role(:participant)
  end

  def self.count_jury
    User.joins(:roles).where(roles: { name: :jury }).count
  end
end
