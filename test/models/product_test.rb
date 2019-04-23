require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # fixtures() directive loads data before each test
  # :products will use the products.yml
  fixtures :products
  
  def new_product(image_url)
    Product.new(
      title: 'My book title',
      description: 'This is a description',
      price: 31,
      image_url: image_url
    )
  end

  test "acceptable image urls" do
    # Create an array of acceptable strings
    ok = %w{ fred.gif chris.jpg chris.png chris.JPG http://hello.com/x/1/chris.PNG }

    # Iterate over acceptable files
    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} should be valid!"
    end
  end

  test "unacceptable image urls" do
    # Create an array of unacceptable strings
    bad = %w{ chris.jpeg hello.docx goodbye.pdf chris.png.no }

    # Iterate over unacceptable files
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} should not be valid!"
    end
  end

  test "product is not valid with a duplicate title" do
    product = Product.new(title: products(:ruby).title,
                          description: "descr",
                          price: 1,
                          image_url: "hello.png")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product title must contain more than 5 characters" do
    product = products(:title_too_short)
    assert product.invalid?
    assert_equal ["Title: #{product.title} must contain at least 5 characters!"], product.errors[:title]
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price cannot be negative" do
    product = Product.new(
      title: 'My book title',
      description: 'This is a description',
      image_url: '123.jpg'
    )
    product.price = -1
    assert product.invalid? # Need this line otherwise will not show up
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price] # Can you asset that the length of the errors is greater than 0 (aka an error)?
  end

  test "product price cannot be 0" do
    product = Product.new(
      title: 'My book title',
      description: 'This is a description',
      image_url: '123.jpg'
    )
    product.price = 0
    assert product.invalid? # Need this line otherwise will not show up
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price] # Can you assert that the length of the errors is greater than 0 (aka an error)?
  end

  test "product price is positive" do
    product = Product.new(
      title: 'My book title',
      description: 'This is a description',
      image_url: '123.jpg'
    )
    product.price = 0.01
    assert product.valid?
  end
end
