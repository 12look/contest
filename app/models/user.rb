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

  scope :not_active_jury, -> { joins(:roles).where(meta_type: 'Jury', roles: {name: :participant}) }
  scope :participants, -> { where(meta_type: 'Participant') }
  scope :juries, -> { joins(:roles).where(roles: {name: :jury}) }

  accepts_nested_attributes_for :meta

  META_TYPES = %w(Participant Jury)

  def build_meta(params)
    raise "Unknown itemizable_type: #{meta_type}" unless META_TYPES.include?(meta_type)
    if new_record?
      self.meta = meta_type.constantize.new(params)
    else
      self.meta.update_attributes(params)
    end
  end

  after_create :assign_default_role

  def assign_default_role
    add_role(:participant) if roles.first.nil?
  end

  def self.count_jury
    User.joins(:roles).where(roles: { name: :jury }).count
  end
end
