require 'spec_helper'
require 'cantango/configuration/shared/candidate_registry_ex'

class MyReg < CanTango::Configuration::CandidateRegistry
end

describe MyReg do
  subject { MyReg.new }

  it_should_behave_like "Candidate Registry" do
  end
end
