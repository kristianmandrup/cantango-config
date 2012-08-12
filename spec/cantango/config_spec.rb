require 'spec_helper'
require 'fixtures/models'

@user = User.new('kris', 'kris@gmail.com')

class CanTango::CustomAbility < CanTango::Ability::Base
  def initialize candidate, options = {}
    'custom'
  end
end

class ApplicationController
end

describe CanTango::Config do
  subject { CanTango.config }

  describe 'ability' do
    specify { subject.ability.should be_a CanTango::Config::Ability }
  end

  describe 'engine' do
    specify { subject.engine(:permits).should be_a CanTango::Config::Engine }
  end

  describe 'hooks' do
    specify { subject.hooks.registered.should be_empty }

    describe 'register hooks' do
      before do
        subject.hooks.register :nime => Proc.new { 2 }
      end
      specify { subject.hooks.registered.should_not be_empty }
      specify { subject.hooks[:nime].should be_a Proc }
    end
  end

  describe 'default_settings!' do
    before do
      subject.default_settings!
    end
    pending
  end

  describe 'localhosts' do
    specify { subject.localhosts.registered.should include('localhost') }
  end

  describe 'orms' do
    specify { subject.orms.registered.should be_empty }

    describe 'register' do    
      before do
        subject.orms.register :mongoid
      end
      specify { subject.orms.registered.should include(:mongoid) }
    end

    describe '<<' do    
      before do
        subject.orms << :mongo_mapper
      end
      specify { subject.orms.registered.should include(:mongo_mapper) }
    end
  end
  
  describe "engines DSL" do
    before(:all) {
      CanTango.configure do |config|
        CanTango.config.engines.each do |engine|
          engine.set :off
        end
     end
    }

    describe 'engine(name)' do
      CanTango.config.engines.registered_names.each do |name|
        specify { subject.engine(name).off?.should be_true}
      end
    end

    describe 'each' do
      CanTango.config.engines.each do |engine|
        specify { engine.on?.should be_false}
        specify { engine.off?.should be_true}
      end
    end
  end
  
  describe 'clear!' do
    pending
  end
end
