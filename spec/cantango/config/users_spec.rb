require 'spec_helper'
require 'cantango/registry/shared/clazz_ex'

class User
end

class Admin
end

class UserAccount
end

class AdminAccount
end


describe CanTango::Config::Users do
  subject { CanTango.config.users }

  it_should_behave_like "Clazz Registry" do
    let(:hash1) do
      {:a => User, :b => Admin}
    end        
  end
  
  describe 'no pollution' do
    let (:config) { CanTango.config }
    before do
      config.users.register     :user,  User
      config.users.register     :admin, Admin

      config.accounts.register  :user,  UserAccount
      config.accounts.register  :admin, AdminAccount

      config.modes.register :no_cache, CanTango::Ability::Mode::NoCache
    end
    
    specify do
      CanTango.config.modes.registered.should == [:no_cache]
    end
  end
end
