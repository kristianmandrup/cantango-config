require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/candidate_registry_ex'

class UserAccount
end

class AdminAccount
end

describe CanTango::Configuration::Accounts do
  subject { CanTango.config.accounts }

  it_should_behave_like "Candidate Registry" do
    let(:hash1) do
      {:a => UserAccount, :b => AdminAccount}
    end    
  end
end