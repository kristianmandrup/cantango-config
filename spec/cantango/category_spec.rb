require 'spec_helper'

describe CanTango::Category do
  subject { CanTango::Category.new 'Wheat', 'Barley' }
  
  describe 'subjects' do
    specify { subject.subjects.should == ['Wheat', 'Barley'] }
  end

  describe 'has_any? name' do
    specify { subject.has_any?('Wheat').should be_true }
  end

  describe 'has_any? name, &block' do
    specify {
      subject.has_any?('Wheat') do
        1.should == 1
      end
    }
  end
end
