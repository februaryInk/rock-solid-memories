load(Rails.root.join("db/seeds/base.rb")) if File.exist?(Rails.root.join("db/seeds/base.rb"))
load(Rails.root.join("db/seeds/mock.rb")) if File.exist?(Rails.root.join("db/seeds/mock.rb"))