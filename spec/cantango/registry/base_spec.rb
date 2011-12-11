require 'spec_helper'
require 'cantango/registry/shared/base_ex'

class MyRegi < CanTango::Registry::Base
end

describe MyRegi do
  subject { MyRegi.new }

  it_should_behave_like "Registry" do
  end
end



