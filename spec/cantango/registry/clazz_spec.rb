require 'spec_helper'
require 'cantango/registry/shared/clazz_ex'

class MyReg < CanTango::Registry::Clazz
end

describe MyReg do
  subject { MyReg.new }

  it_should_behave_like "Clazz Registry" do
  end
end
