require 'spec_helper'

class Enabler
  include CanTango::Config::OnOff
end

describe CanTango::Config::OnOff do
  subject { Enabler.new }

  its(:on) { should be_nil }
  its(:off) { should be_nil }

  its(:on?) { should be_false }
  its(:off?) { should be_true }

  describe '.on!' do
    before { subject.on! }
      
    its(:on?) { should be_true }
    its(:off?) { should be_false }
  end

  describe '.off!' do
    before { subject.off! }
      
    its(:on?) { should be_false }
    its(:off?) { should be_true }
  end
end