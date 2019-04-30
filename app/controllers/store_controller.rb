class StoreController < ApplicationController
  def index
    # Get all products in alphabetical order
    @products = Product.order(:title)

    # Count how many times the user has accessed this action!
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
    @counter = session[:counter]

  end
end
