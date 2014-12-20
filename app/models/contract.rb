class Contract < ActiveRecord::Base
  belongs_to :site

  has_attached_file :document
  validates_attachment :document,
                    content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) },
                    size: { in: 0..1000.kilobytes }

  has_attached_file :ers_sign_image
  validates_attachment :ers_sign_image,
                    content_type: { content_type: /^image\/(jpeg|jpg|png|gif|tiff)$/ },
                    size: { in: 0..500.kilobytes }

  has_attached_file :customer_sign_image
  validates_attachment :customer_sign_image,
                    content_type: { content_type: /^image\/(jpeg|jpg|png|gif|tiff)$/ },
                    size: { in: 0..500.kilobytes }

  validates :signed_at, :price, :site_id, presence: true
end