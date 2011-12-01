module CanTango
  autoloader_scope :ns => {:CanTango => 'cantango/config_ext'} do
    autoload_modules :Loader
  end
end