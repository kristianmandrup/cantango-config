require 'spec_helper'
require 'cantango/configuration/shared/execution_modes_ex'

class User
end

class MyAbility
  include CanTango::Configuration::ExecutionModes
end

describe CanTango::Configuration::ExecutionModes do
  subject { MyAbility.new }

  it_should_behave_like "Execution Modes"
end
