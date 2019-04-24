require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  # Data based on fixtures!
  test "should get index" do
    get store_index_url
    assert_response :success
    # Selectors that start w # match on 'id' attributes
    # Selectors that start w . match on class attributes
    # Selectors that contain no prefix match on element names
    assert_select 'nav.side_nav a', minimum: 4 
    assert_select 'main ul.catalog li', 4 
    assert_select 'h2', 'Ruby Performance Optimization' 
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
