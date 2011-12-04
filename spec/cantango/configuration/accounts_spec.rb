require 'spec_helper'
require 'cantango/configuration/shared/registry/clazz_ex'

class UserAccount
end

class AdminAccount
end

describe CanTango::Configuration::Accounts do
  subject { CanTango.config.accounts }

  it_should_behave_like "Clazz Registry" do
    let(:hash1) do
      {:a => UserAccount, :b => AdminAccount}
    end    
  end
end
