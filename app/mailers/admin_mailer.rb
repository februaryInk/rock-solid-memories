class AdminMailer < ApplicationMailer
  default :to => ENV[ 'ADMIN_EMAIL' ]
  
  # INSTANCE METHODS
  
  def contact_us( email )
    @content = email.content
    @name = email.name
    @return_email_address = email.return_email_address
    @subject = email.subject
    
    mail(
      from: @return_email_address,
      subject: @subject,
      template_path: 'admin_mailer'
    )
  end
end
