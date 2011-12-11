require 'spec_helper'
require 'cantango/registry/shared/clazz_ex'

class ModeA
end

class ModeB
end

describe CanTango::Configuration::Modes do
  subject { CanTango.config.modes }

  it_should_behave_like "Clazz Registry" do
    let(:hash1) do
      {:a => ModeA, :b => ModeB}
    end        
  end
end
