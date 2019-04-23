class Product < ApplicationRecord
  # Check that the text fields all contain something
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { 
    minimum: 5,
    message: "Title: %{value} must contain at least 5 characters!"
  }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for a GIF, JPG, or PNG image!'
  }
end
