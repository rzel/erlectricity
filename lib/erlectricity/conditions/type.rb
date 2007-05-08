module Erlectricity
class TypeCondition < Condition
  attr_accessor :type
  
  def initialize(type, name=nil)
    self.type = type
    super(name)
  end
  
  def satisfies?(arg)
    arg.is_a? self.type
  end
  
  def bindings_for(arg)
    return {} unless self.binding_name
    {self.binding_name => arg}
  end
end
end