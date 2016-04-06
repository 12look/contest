class Work < ActiveRecord::Base
  paginates_per 12

  belongs_to :user
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :images, dependent: :destroy

  has_attached_file :file, styles: { medium: "600x600", thumb: "300x300#" }, default_url: ""
  validates_attachment :file, presence: true
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  validates :name, length: { in: 3..30 }
  validates :description, length: { in: 10..1000 }

  validates :name, :description, :category, :archive_url, presence: true

  validates :archive_url, url: true

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  resourcify

  def count_jury
    self.ratings.select(:user_id).uniq.count
  end
end
