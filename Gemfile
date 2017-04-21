source 'https://rubygems.org'

# The essential Rails gem.
gem 'rails', '5.0.1'

# Add browser-specific CSS prefixes automatically.
gem 'autoprefixer-rails'

# Pretty print structures in the console using `ap`.
gem 'awesome_print'

gem 'coffee-script'

# Load environment variables from .env.
gem 'dotenv-rails'

# Import the Font Awesome icons.
gem 'font-awesome-rails'

# Use HAML markup.
gem 'haml-rails', '~> 0.9'

# Use the JavaScript library jQuery.
gem 'jquery-rails'

# Use normalize.css to standardize how browsers render elements.
gem 'normalize-rails'

# Use the PostgreSQL database gem.
gem 'pg', '0.18.4'

# Use stylesheets to style emails rather than having to write everything inline.
gem 'premailer-rails'

# Use the web server Puma.
gem 'puma'

# Use SCSS for stylesheets.
gem 'sass-rails', '~> 5.0'

gem 'spree', :path => '/home/farrah/Rails/spree_custom/', :branch => '3-2-stable-custom'
gem 'spree_auth_devise', '~> 3.2.0.beta'
gem 'spree_gateway', '~> 3.2.0.beta'

# Make navigating the application faster.
gem 'turbolinks', '~> 5.x'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

source 'https://rails-assets.org' do
  # Import the lightweight Unsemantic CSS grid.
  gem 'rails-assets-unsemantic'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console.
  gem 'byebug', :platform => :mri
  
  # Listen to file modifications.
  gem 'listen', '~> 3.0.5'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  
  # Handle automated deployment with Capistrano.
  gem 'capistrano', :require => false
  gem 'capistrano-bundler', :require => false
  gem 'capistrano-rails', :require => false
  gem 'capistrano-rvm', :require => false
  gem 'capistrano3-puma', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem.
gem 'tzinfo-data', platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]
