require 'spec_helper'

class Xaz
end

describe CanTango::Config::Ability::Modes::Execution do
  subject { CanTango::Config::Ability::Modes::Execution.instance }

  describe 'valid mode=' do
    before do
      subject.register :cache
    end
    specify { subject.registered.should include :cache }
  end

  describe 'clear! and invalid mode=' do
    before do
      subject.clear!
      subject.register Xaz
    end

    specify { subject.registered.should be_empty }
  end

  describe 'reset!' do
    before do
      subject.register :a, :b
      subject.reset!
    end

    specify { subject.registered.should == subject.default }
  end
end
