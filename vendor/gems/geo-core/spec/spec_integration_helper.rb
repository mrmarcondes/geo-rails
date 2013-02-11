require 'spec_helper'
require 'database_cleaner'

Mongoid.load!("./lib/mongoid.yml", :test)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.orm = :mongoid
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end