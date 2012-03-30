require "active_record"
require "invitable/version"
require "invitable/invitable"

Dir["lib/models/*.rb"].each { |f| require f }

