class StoreController < ApplicationController
  def index
    # Get all products in alphabetical order
    @products = Product.order(:title)
  end
end
