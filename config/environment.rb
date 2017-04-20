require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/database.sqlite')
require_all 'app'

ActiveRecord::Base.logger.level = 1

# require_relative File.join(File.dirname(__FILE__), "..", "app/models", "team.rb")
# require_relative File.join(File.dirname(__FILE__), "..", "app/models", "season.rb")
