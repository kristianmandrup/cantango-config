require 'rspec'
require 'cantango/config'
require 'active_record'

require 'cutter'
require 'yaml'
require 'logger'
require 'database_cleaner'

require 'factory_girl'
FactoryGirl.find_definitions

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
end

def connect_db
  path = File.dirname(__FILE__) + '/db/database.yml'
  dbfile = File.open(path)
  dbconfig = YAML::load(dbfile)
  ActiveRecord::Base.establish_connection(dbconfig)
  ActiveRecord::Base.logger = Logger.new(STDERR)
  DatabaseCleaner.clean  
end

def migrate
  folder = File.join(File.dirname(__FILE__), 'migrations')
  puts "Migrate: #{folder}"
  ActiveRecord::Migrator.migrate folder
end