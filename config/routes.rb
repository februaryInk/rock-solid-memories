Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
          
  resources :products, :only => [ :index ]
  
  get  '/old/contact-us', :to => 'emails#new', :as => 'new_email'
  post '/old/contact-us', :to => 'emails#create', :as => 'emails'
  
  get '/about', :to => 'base_pages#about'
  
  get '/sitemap.xml' => 'sitemaps#index', :format => 'xml', :as => 'sitemap'
  
  get '/home' => 'base_pages#home'
  
  match '*path' => redirect( '/' ), :via => [ :get, :post ]
end
