class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :LineItems, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category_id, presence: true

  def average_rating
    if reviews.count > 0
      reviews.sum('rating') / reviews.count
    end
  end
end
