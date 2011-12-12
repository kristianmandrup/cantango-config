require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

class MyEngine < CanTango::Engine
end

class MyOtherEngine < CanTango::Engine
end


describe CanTango::Config::Engines do
  subject { CanTango.config.engines }

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
end