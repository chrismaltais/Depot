class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  def add_product(product)
    # line_items belongs to the Cart object
    existing_item = line_items.find_by(product_id: product.id)
    puts "Existing Item: #{existing_item}"
    if existing_item
      existing_item.quantity += 1 
    else
      existing_item = line_items.build(product_id: product.id)
    end
    existing_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price}
  end
end
