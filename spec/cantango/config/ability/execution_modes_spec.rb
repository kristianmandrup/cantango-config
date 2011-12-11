require 'spec_helper'
require 'cantango/configuration/shared/execution_modes_ex'

class User
end

class MyAbility
  include CanTango::Config::ExecutionModes
end

describe CanTango::Config::ExecutionModes do
  subject { MyAbility.new }

  it_should_behave_like "Execution Modes"
end
