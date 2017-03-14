Rails.application.routes.draw do
  
  resources :products, :only => [ :index ]
  
  get  '/contact-us', :to => 'emails#new', :as => 'new_email'
  post '/contact-us', :to => 'emails#create', :as => 'emails'
  
  get '/about', :to => 'base_pages#about'
  
  get '/sitemap.xml' => 'sitemaps#index', :format => 'xml', :as => 'sitemap'
  
  root :to => 'base_pages#home'
  
  match '*path' => redirect( '/' ), :via => [ :get, :post ]
end
