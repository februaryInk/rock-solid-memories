require 'test_helper'

class BasePagesControllerTest < ActionDispatch::IntegrationTest
  
  test 'should get about' do
    get about_url
    assert_response :success
  end
  
  test 'should get home' do
    get root_url
    assert_response :success
  end
end
