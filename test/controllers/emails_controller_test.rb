require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  
  test 'should get new' do
    get new_email_url
    assert_response :success
  end
end
