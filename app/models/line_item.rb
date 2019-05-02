class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    # Where is product referenced? How can product just be called like that?
    # From the belongs_to?
    product.price * quantity
  end
end
