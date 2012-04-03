require 'rails/generators/migration'

module Invitable
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      desc "Generate invitable migration"

      def self.source_root
        @source_root ||= File.expand_path('../templates', __FILE__)
      end

      def self.next_migration_number(path)
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_migration_file
        migration_template 'migration.rb', File.join('db','migrate', 'create_invitations.rb')
      end
    end
  end
end
