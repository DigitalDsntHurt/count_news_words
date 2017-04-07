require 'test_helper'

class LandControllerTest < ActionDispatch::IntegrationTest
  test "should get publications" do
    get land_publications_url
    assert_response :success
  end

end
