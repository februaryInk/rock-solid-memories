class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  layout 'default'
  
  before_action :lockout
  
  private
    
    def lockout
      # render 'shared/lockout', :layout => 'simple' if ENV[ 'LOCKOUT' ].to_s == 'true'
    end
end
