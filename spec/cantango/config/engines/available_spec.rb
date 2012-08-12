require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

class MyEngine < CanTango::Engine
  include CanTango::Config::OnOff
end

class MyOtherEngine < CanTango::Engine
  include CanTango::Config::OnOff
end


describe CanTango::Config::Engines do
  subject { CanTango.config.engines }

  context 'default config' do
    describe '.available' do
      its(:available) { should be_empty }
    end

    describe '.available? name' do
      specify { subject.available?(:permits).should be_false }
    end

    describe '.all' do
      describe ':on' do
        specify { subject.all(:on).should be_empty }
      end

      describe ':off' do    
        specify { subject.all(:off).should be_empty }
      end
    end

    describe '.any?' do
      describe ':on' do
        specify { subject.any?(:on).should be_false }
      end

      describe ':off' do
        specify { subject.any?(:off).should be_false }
      end
    end
  end

  context 'registered :my and :other engine' do
    before do
      CanTango.config.engines << {:my => MyEngine}
      CanTango.config.engines << {:other => MyOtherEngine}

      CanTango.config.engine(:my) do |engine|
      end
    end

    describe '.available' do
      its(:available) { should include('my', 'other') }
    end

    describe '.available? name' do
      specify { subject.available?(:my).should be_true }
    end

    describe '.all' do
      describe ':on' do
        specify { subject.all(:on).should include(MyEngine, MyOtherEngine) }
      end

      describe ':off' do    
        specify { subject.all(:off).should be_empty }
      end
    end

    describe '.any?' do
      describe ':on' do
        specify { subject.any?(:on).should be_true }
      end

      describe ':off' do
        specify { subject.any?(:off).should be_false }
      end
    end
  end
end