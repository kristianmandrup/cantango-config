require 'spec_helper'
require 'cantango/configuration/shared/registry/hash_ex'

class MyEngine < CanTango::Engine
end

class MyOtherEngine < CanTango::Engine
end


describe CanTango::Configuration::Modes do
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

  describe 'execution order' do    
    before do
      subject.set_execution_order :my_other_engine, :engine, :my_engine, :my_other_engine
    end
    
    its(:execution_order) { should == ['my_other_engine', 'my_engine'] }
  end
  
  describe 'excute_first' do
    before do
      subject.set_execution_order :my_other_engine, :my_engine
      subject.execute_first :my_engine
    end
    
    its(:execution_order) { should == ['my_engine', 'my_other_engine'] }
  end

  describe 'execute_last' do
    before do
      subject.set_execution_order :my_other_engine, :my_engine
      subject.execute_last :my_other_engine
    end
    
    its(:execution_order) { should == ['my_engine', 'my_other_engine'] }
  end

  describe 'execute_before' do
    before do
      subject.set_execution_order :my_other_engine, :my_engine
      subject.execute_before :my_other_engine, :my_engine
    end
    
    its(:execution_order) { should == ['my_engine', 'my_other_engine'] }
  end

  describe 'execute_after' do
    before do
      subject.set_execution_order :my_other_engine, :my_engine
      subject.execute_after :my_engine, :my_other_engine, 
    end
    
    its(:execution_order) { should == ['my_engine', 'my_other_engine'] }
  end
  
  # all state
  # any? state
  # clear!
  # each
  # active? name
  # active
end