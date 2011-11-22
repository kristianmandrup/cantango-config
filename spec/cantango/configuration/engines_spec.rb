require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/hash_registry_ex'

class MyEngine < CanTango::Engine
end

describe CanTango::Configuration::Modes do
  subject { CanTango.config.engines }

  it_should_behave_like "Hash Registry" do
  end
  
  specify do 
    lambda { subject.register :my_engine => 3 }.should raise_error
  end
  
  specify do
    lambda { subject.register :my_engine => MyEngine }.should_not raise_error
  end
  
  describe '#registered' do
    before do
      subject.register :my_engine => MyEngine
    end
    
    specify { subject.registered[:my_engine].should == MyEngine }
  end

  describe 'execution order' do
    # execution_order= *names
    # execute_first name
    # execute_last name
    # execute_before existing, name
    # execute_after existing, name
    # execution_order
  end
  
  # available
  # available? name
  # all state
  # any? state
  # clear!
  # each
  # active? name
  # active
end