require 'spec_helper'
require 'cantango/registry/shared/base_ex'

describe CanTango::Configuration::Localhosts do
  subject { CanTango.config.localhosts }

  it_should_behave_like "Registry" do
  end
end
