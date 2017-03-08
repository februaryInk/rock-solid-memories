class Email
  
  include ActiveModel::Model
  
  EMAIL_REGEX = /(.+)(@)(.+)(\.)(.+)/

  # Text, text, text, text
  attr_accessor :content, :name, :return_email_address, :subject
  
  # VALIDATIONS

  validates :content, :presence => true
  validates :name, :presence => true
  validates :return_email_address, :presence => true, :format => { :with => EMAIL_REGEX }
  validates :subject, :presence => true
end
