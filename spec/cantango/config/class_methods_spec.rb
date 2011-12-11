require 'spec_helper'

class Context
  extend CanTango::Config::ClassMethods
end

# Note: This config feature is currently not used, but could potentially be of use in the future
describe CanTango::Config::ClassMethods do
  subject { CanTango::Config::ClassMethods.new }
  
  pending
end
