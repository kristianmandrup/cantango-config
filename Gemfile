source :rubygems

gem 'rails', '>= 3.1'
gem 'cantango', :git => 'git://github.com/kristianmandrup/cantango', :branch => 'major-refactor' 
#:path => '/Users/kmandrup/repos/private/cantango' 
# :git => 'git://github.com/kristianmandrup/cantango', :branch => 'major-refactor' 
#, :path => '/Users/kmandrup/pr/stanislaw/cantango', :branch => 'major-refactor'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "bundler",  ">= 1.1.rc"
  gem "jeweler",  ">= 1.6.4"
  gem "rcov", ">= 0"
end

group :test do
  gem 'require_all', '~> 1.2.0'

  # gem 'permits', :git => 'git://github.com/kristianmandrup/permits'

  # Data
  gem 'database_cleaner'
  # gem 'factory_girl'

  # Specs
  gem 'spork'

  # Debug and performance tests
  gem 'cutter'
  
  # Adapters
  gem 'sourcify'
  gem 'dkastner-moneta',  '>= 1.0'
end

group :test, :development do
  gem "rspec",    ">= 2.6.0"
end
