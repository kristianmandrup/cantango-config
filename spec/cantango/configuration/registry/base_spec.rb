require 'spec_helper'
require 'cantango/configuration/shared/registry/base_ex'

class MyRegi < CanTango::Configuration::Registry::Base
end

describe MyRegi do
  subject { MyRegi.new }

  it_should_behave_like "Registry" do
  end
end



