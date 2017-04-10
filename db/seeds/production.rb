load(Rails.root.join("db/seeds/base.rb")) if File.exist?(Rails.root.join("db/seeds/base.rb"))

# To seed the production environment with the mock data in addition to the base
# data, run `rake db:seed mock=true`.
if ENV['mock']
  load(Rails.root.join("db/seeds/mock.rb")) if File.exist?(Rails.root.join("db/seeds/mock.rb"))
end