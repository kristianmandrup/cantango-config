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
