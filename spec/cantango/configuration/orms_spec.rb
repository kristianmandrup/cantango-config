require 'spec_helper'
require 'cantango/registry/shared/base_ex'

describe CanTango::Configuration::Orms do
  subject { CanTango.config.orms }

  it_should_behave_like "Registry" do
  end
end
