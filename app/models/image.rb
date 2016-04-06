class Image < ActiveRecord::Base
  belongs_to :work

  has_attached_file :image, styles: { thumb: "200x200>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
