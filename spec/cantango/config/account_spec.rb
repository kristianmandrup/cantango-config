require 'spec_helper'

class BaseAccount
  def initialize
  end
end


describe CanTango::Configuration::Account do
  subject { CanTango.config.account }

  describe 'set base class' do
    before do
      subject.base_class = BaseAccount
    end

    its(:base_class) { should == BaseAccount }
  end
end


