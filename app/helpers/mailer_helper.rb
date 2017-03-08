module MailerHelper
  
  def mailer_image_tag( file, **options )
    attachments.inline[ file ] = {
      data: File.read( "#{Rails.root}/app/assets/images/#{file}" ),
    }
    image_tag( attachments.inline[ file ].url, **options )
  end
end
