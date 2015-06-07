class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_attached_file :file, :styles => { :medium => "600x600", :thumb => "300x300#" }, :default_url => ""
  validates_attachment :file, :presence => true
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  
  has_attached_file :video, :default_url => ""
  validates_attachment_content_type :video, :content_type => 'video/mp4'
  validates_attachment :video, presence: true, if: :category_with_video?

  validates :name, :description, :category, presence: true

  def category_with_video?
  	category.isvideo == true
  end
end
