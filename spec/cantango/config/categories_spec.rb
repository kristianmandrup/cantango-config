require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

describe CanTango::Config::Categories do
  subject { CanTango.config.categories }

  describe 'API' do
    before(:each) do
      categories = {:a => ['B', 'C'], 'x' => ['Y', 'Z'], 'v' => ['B', 'Z']}

      subject.clean!
      subject.register categories
    end

    describe 'get index []' do
      before do
        subject.register(:w => 'something non-array!')
      end

      specify { subject.category(:w).should_not be_empty }
      specify { subject.category('w').should be_empty }
    end

    describe 'category_has_subject?' do
      specify { subject.category('a').has_any?('B').should be_true }
    end

    describe 'has_subject?' do
      specify { subject.has_any?('Y').should be_true }
    end

    describe 'category_names_of_subject' do
      specify { subject.category_names_of_subject('B').last.should == 'v' }

      specify { subject.category_names_of_subject('c').first.should == nil }
    end

    describe 'categories_of_subject' do
      specify do
        subject.categories_of_subject('B').should == {'a' => ['B', 'C'], 'v' => ['B', 'Z'],}
      end

      specify do
        subject.categories_of_subject('blip').should == {}
      end
    end
  end
end


