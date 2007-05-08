module Erlectricity
  class Condition
    attr_accessor :binding_name
  
    def initialize(binding_name=nil)
      self.binding_name = binding_name
    end
  
    def bindings_for(arg)
      {}
    end
  
    def satisfies?(arg)
      false
    end
  
  end

  module Conditions
    def atom(name=nil)
      TypeCondition.new(Symbol, name)
    end
  
    def any(name=nil)
      TypeCondition.new(Object, name)
    end
  
    def number(name=nil)
      TypeCondition.new(Fixnum, name)
    end
  
    def pid(name=nil)
      TypeCondition.new(Erlectricity::Pid, name)
    end
  
    def string(name=nil)
      TypeCondition.new(String, name)    
    end
  
    def list(name=nil)
      TypeCondition.new(Array, name)    
    end
  
    def hash(name=nil)
      HashCondition.new(name)
    end
  end
end