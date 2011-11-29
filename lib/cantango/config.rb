require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'sweetloader'

require 'cantango/core'

SweetLoader.namespaces = {:CanTango => 'cantango'}
SweetLoader.mode = :require

module CanTango
  autoload_modules :Configuration, :ClassMethods
  include ClassMethods
end