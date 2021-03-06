require 'spec_helper'

# Note: This config feature is currently not used, but could potentially be of use in the future
describe CanTango::Config::Debug do
  subject { CanTango.config.debug }

  describe 'should set debug mode :on' do
    before do
      subject.set :on
    end

    its(:on?) { should be_true }
    its(:off?) { should be_false }
  end

  describe 'should set debug mode :off' do
    before do
      subject.set :on
    end

    its(:on?)   { should be_true  }
    its(:off?)  { should be_false }
  end

  describe 'debug! should set debug mode :on' do
    before do
      CanTango.debug!
    end

    its(:on?) { should be_true }
    its(:off?) { should be_false }
  end
end

