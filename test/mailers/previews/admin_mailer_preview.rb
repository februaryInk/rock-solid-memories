# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/contact_us
  def contact_us
    email = Email.new(
      :content => 'This is a test.',
      :name => 'Test User',
      :return_email_address => 'testuser@example.com',
      :subject => 'Testing the Contact Us Email'
    )
    AdminMailer.contact_us( email )
  end
end
