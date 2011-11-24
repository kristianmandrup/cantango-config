require 'spec_helper'
require 'cantango/configuration/shared/factory_ex'
require 'cantango/configuration/shared/modes_ex'

describe CanTango::Configuration::Ability do
  subject { CanTango.config.ability }
    
  it_should_behave_like 'Factory'

  it_should_behave_like 'Modes'
end


