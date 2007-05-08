module Erlectricity
class HashCondition < Condition

  def satisfies?(arg)
    return false unless arg.class == Array
    arg.all?{|x| x.class == Array && x.length == 2}
  end
  
  def bindings_for(arg)
    return {} unless self.binding_name
    flattened = arg.inject([]){|memo, kv| memo + kv}
    {self.binding_name => Hash[*flattened]}
  end
end
end