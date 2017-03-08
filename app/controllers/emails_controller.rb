class EmailsController < ApplicationController
  
  def create
    @email = Email.new(email_params)
    
    if @email.valid?
      mail = AdminMailer.contact_us(@email)
      mail.deliver_now
      flash[ :success ] = 'Your message has been sent.'
      redirect_to new_email_path
    else
      render :new
    end
  end
  
  def new
    @email = Email.new
  end
  
  private
  
    def email_params
      params.require( :email ).permit(
        :content,
        :name,
        :return_email_address,
        :subject
      )
    end
end
