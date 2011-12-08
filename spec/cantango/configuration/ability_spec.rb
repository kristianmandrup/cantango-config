require 'spec_helper'
require 'cantango/configuration/shared/factory_ex'
require 'cantango/configuration/shared/execution_modes_ex'

class MyExecutor
end

describe CanTango::Configuration::Ability do
  subject { CanTango.config.ability }
    
  it_should_behave_like 'Factory'

  it_should_behave_like 'Execution Modes'

  describe 'default_executor_class' do
    specify { subject.default_executor_class.should == CanTango::Ability::Executor::Modal }
  end

  describe 'default_executor_class' do
    specify { subject.default_executor_class.should == CanTango::Ability::Executor::Modal }
  end

  describe 'default_executor_class=' do
    specify do
      lambda { subject.default_executor_class = 's' }.should raise_error
    end

    specify do
      subject.default_executor_class = MyExecutor
      subject.default_executor_class.should ==  MyExecutor
    end
  end

  describe 'default_class' do
    specify { subject.default_class.should == CanTango::Ability::Base }
  end

  describe 'factory_class_method' do
    specify { subject.factory_class_method.should == :default_executor_class }
  end

end


