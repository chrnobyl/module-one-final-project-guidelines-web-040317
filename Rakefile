# require_relative 'config/environment'
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/database.sqlite')

require_relative File.join(File.dirname(__FILE__), "app/models", "team.rb")
require_relative File.join(File.dirname(__FILE__), "app/models", "season.rb")



require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  # ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end
