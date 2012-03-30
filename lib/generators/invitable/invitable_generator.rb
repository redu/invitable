require 'rails/generators'
require 'rails/generators/migration'

module Invitable
  class InvitableGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def self.next_migration_number(path)
      if ActiveRecord::Base.timestamped_migrations
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname)+1)
      end
    end
  end

  def create_migration_file
    mirgration_template 'migration.rb', 'db/migrate/create_invitations.rb'
  end
end
