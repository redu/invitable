require 'active_record'
require "invitable/version"
require "invitable/invitable"

Dir["app/models/**/*.rb"].each { |f| require f }
