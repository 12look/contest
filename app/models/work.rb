class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :images, :dependent => :destroy

  has_attached_file :file, styles: { medium: "600x600", thumb: "300x300#" }, default_url: ""
  validates_attachment :file, presence: true
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  validates :name, length: { in: 3..30 }

  validates :name, :description, :category, presence: true

  accepts_nested_attributes_for :images, :reject_if => :all_blank, allow_destroy: true

end
