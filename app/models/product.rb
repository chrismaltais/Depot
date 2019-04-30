class Product < ApplicationRecord
  has_many :line_items
  # Call hook method before destroying product
  before_destroy :ensure_not_referenced_by_any_line_item

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

  private
    # Ensure there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        # Add an error to the Errors base object 
        # (different to adding an error to an attribute like in validate)
        errors.add(:base, 'Line Items present')
        # If abort is thrown, object is not destroyed
        throw :abort
      end
    end
end
