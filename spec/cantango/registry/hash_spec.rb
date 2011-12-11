require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

class MyRegis < CanTango::Configuration::Registry::Hash
end

describe MyRegis do
  subject { MyRegis.new }

  it_should_behave_like "Hash Registry" do
    let(:hash1) do
      {:a => 1, :b => 2}
    end
    
    let(:hash2) do
      {:c => 3}
    end    
  end
end



