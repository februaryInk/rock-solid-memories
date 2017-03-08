require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  
  test 'contact_us' do
    email = Email.new(
      :content => 'This is a test.',
      :name => 'Test User',
      :return_email_address => 'testuser@example.com',
      :subject => 'Testing the Contact Us Email'
    )
    mail = AdminMailer.contact_us( email )
    assert_equal 'Testing the Contact Us Email', mail.subject
    assert_equal ENV[ 'ADMIN_EMAIL' ], mail.to[ 0 ]
  end
end
