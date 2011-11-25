require 'spec_helper'
require 'cantango/configuration/shared/registry/candidate_ex'

class MyReg < CanTango::Configuration::Registry::Candidate
end

describe MyReg do
  subject { MyReg.new }

  it_should_behave_like "Candidate Registry" do
  end
end
