class Paper < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: {maximum: 255}

  has_one_attached :image
end
