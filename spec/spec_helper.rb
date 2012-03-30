require 'sqlite3'
require 'invitable'
require 'active_record'
require 'factory_girl'
require 'shoulda-matchers'

Dir["app/models/**/*.rb"].each { |f| require f }
Dir["spec/factories/**/*.rb"].each { |f| require f }

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

load("schema.rb")

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
