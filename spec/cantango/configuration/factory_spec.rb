require 'spec_helper'
require 'cantango/configuration/shared/factory_ex'

AliasedCustomFactory = CustomFactory

class MyFactory
  include CanTango::Configuration::Factory 
  include Singleton
  
  def default_class
    AliasedCustomFactory
  end

  def default_executor_class
    CustomFactory
  end

  attr_writer :factory_class_method

  def factory_class_method
    @factory_class_method ||= :default_executor_class
  end
end

describe CanTango::Configuration::Factory do
  subject { MyFactory.instance }

  it_should_behave_like 'Factory'
  
  describe 'using factory_class_method to point to default_class' do
    before :each do
      subject.clear_factory!
    end

    it 'should set it' do
      subject.factory_build('hello', :works => true).name.should == 'hello'
    end
  end  
  
  describe 'using default_class as fallback' do
    before do
      subject.clear_factory!
      subject.factory_class_method = ''
    end
    
    specify { subject.factory_class_method.should be_blank }

    it 'should set it' do
      subject.factory_build('hello', :works => true).name.should == 'hello'
    end
    
    describe 'no factory defined' do
      before do
        AliasedCustomFactory = nil
      end
      
      specify do
        lambda { subject.factory_build('hello', :works => true) }.should raise_error
      end
    end
  end
end


