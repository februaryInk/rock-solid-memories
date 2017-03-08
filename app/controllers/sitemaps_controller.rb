class SitemapsController < ApplicationController
  
  def index
    headers[ 'Content-Type' ] = 'application/xml'
    
    respond_to do | format |
      format.xml { render :layout => false }
    end
  end
end
