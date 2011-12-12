require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

class MyEngine < CanTango::Engine
end

class MyOtherEngine < CanTango::Engine
end


describe CanTango::Config::Engines do
  subject { CanTango.config.engines }

  it_should_behave_like "Hash Registry" do
    let(:hash1) do
      {:my_engine => MyEngine}
    end

    let(:hash2) do
      {:my_other_engine => MyOtherEngine}
    end
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
    specify { subject.registered_names.should include('my_engine') }
    specify { subject.available.should include('my_engine') }    
    specify { subject.available?('my_engine').should be_true }
    specify { subject.available?('not_my_engine').should be_false }
  end

  let(:engines) do
    {:my_engine => MyEngine}.merge :my_other_engine => MyOtherEngine
  end

  before do
    subject.register engines
  end

  
  # all state
  # any? state
  # clear!
  # each
  # active? name
  # active
end