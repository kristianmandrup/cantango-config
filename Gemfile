source :rubygems

gem 'rails', '>= 3.1'
gem 'cantango', :path => '/Users/kmandrup/pr/stanislaw/cantango'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec",    ">= 2.6.0"
  gem "bundler",  ">= 1.1.rc"
  gem "jeweler",  ">= 1.6.4"
  gem "rcov", ">= 0"
end

group :test do
  gem 'require_all', '~> 1.2.0'

  # Data
  gem 'database_cleaner'
  # gem 'factory_girl'

  # Specs
  gem 'spork'

  # Debug and performance tests
  gem 'cutter'
end