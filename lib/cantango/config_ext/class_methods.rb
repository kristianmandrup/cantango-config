def configure &block
  conf = CanTango::Configuration.instance
  yield conf if block
  conf
end

alias_method :config, :configure
