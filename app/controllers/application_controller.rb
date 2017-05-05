class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  layout 'default'
  
  before_action :display_message
  before_action :lockout
  
  private
    
    def display_message
      flash[ :info ] = ENV[ 'MESSAGE' ] if ENV[ 'MESSAGE' ]
    end
    
    def lockout
      # render 'shared/lockout', :layout => 'simple' if ENV[ 'LOCKOUT' ].to_s == 'true'
    end
end
