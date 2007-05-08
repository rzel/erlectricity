module Erlectricity
class StaticCondition < Condition
  attr_accessor :value
  def initialize(value, name=nil)
    self.value = value
    super(name)
  end
  
  def satisfies?(arg)
    arg.eql? value
  end
  
  def bindings_for(arg)
    {}
  end
end
end