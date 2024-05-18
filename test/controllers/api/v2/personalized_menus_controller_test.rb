require "test_helper"

class Api::V2::PersonalizedMenusControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v2_personalized_menus_create_url
    assert_response :success
  end
end
