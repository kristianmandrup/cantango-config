require 'spec_helper'
require 'cantango/registry/shared/hash_ex'

class MyEngine < CanTango::Engine
end

class MyOtherEngine < CanTango::Engine
end


describe CanTango::Config::Engines do
  subject { CanTango.config.engines }

  def available
    registered_names
  end

  def available? name
    available.include? name.to_s
  end

  def all state
    available.each {|engine| send(engine).set state }
  end

  def any? state
    available.any? {|engine| send(engine).send(:"#{state}?") if respond_to?(engine) }
  end
end