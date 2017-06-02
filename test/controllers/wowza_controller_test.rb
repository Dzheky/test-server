require 'test_helper'

class WowzaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wowza_index_url
    assert_response :success
  end

end
