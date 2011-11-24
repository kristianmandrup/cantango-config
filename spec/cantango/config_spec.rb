# dir = File.dirname(__FILE__) + '/../../lib'
# $LOAD_PATH.unshift(dir)
require 'rspec'
# puts dir
# require File.expand_path('cantango/config.rb', dir)

require 'cantango/config'

describe 'cantango/config' do
  specify do 
    lambda { CanTango::Configuration }.should_not raise_error
  end
end
