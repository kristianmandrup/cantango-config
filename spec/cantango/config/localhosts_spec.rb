require 'spec_helper'
require 'cantango/registry/shared/base_ex'

describe CanTango::Config::Localhosts do
  subject { CanTango.config.localhosts }

  it_should_behave_like "Registry"
end
