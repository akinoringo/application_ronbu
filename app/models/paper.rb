class Paper < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: {maximum: 255}

  has_one_attached :pdf

  def self.search(search)
    return Paper.all unless search
    Paper.where(['content LIKE ?', "%#{search}%"])
  end
end
