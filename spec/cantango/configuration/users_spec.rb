require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/candidate_registry_ex'

class User
end

class Admin
end

describe CanTango::Configuration::Users do
  subject { CanTango.config.users }

  it_should_behave_like "Candidate Registry" do
    let(:hash1) do
      {:a => User, :b => Admin}
    end        
  end
end
