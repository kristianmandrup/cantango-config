require 'rspec'
require 'cantango/config'

describe 'cantango/config' do
  specify do 
    lambda { CanTango::Configuration }.should_not raise_error
  end
end
