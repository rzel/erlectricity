module Erlectricity
class Matcher
  attr_accessor :condition, :block
  attr_accessor :receiver
  
  def initialize(parent, condition, block)
    self.receiver = parent
    @block = block
    @condition = condition
  end
  
  def run(arg)
    context = MatchContext.new(self.receiver) 

    populate_context context, arg
    context.instance_eval &block
  end
  
  def matches?(arg)
    if @condition.is_a?(Array)
      return false unless arg.is_a?(Array)
      return false if @condition.length != arg.length
      @condition.zip(arg).all?{|l,r| l.satisfies?(r)}
    else
      @condition.satisfies?(arg)
    end
  end
  

  private
  def populate_context(context, arg)
    if @condition.is_a?(Array) && arg.is_a?(Array)
      @condition.zip(arg).all?{|l,r| set_binding(context, l, r)}
    else
      set_binding(context, condition, arg)
    end
  end
  
  def set_binding(context, condition, arg)
    condition.bindings_for(arg).each do |k, v|
      add_to_context(context, k, v)
    end
  end
  
  def add_to_context(context, name, value)
    return if name.nil?
    
    context.instance_eval <<-EOS
      def #{name}
        @#{name}
      end
      def #{name}= (value)
        @#{name} = value
      end
    EOS
    
    context.send(:"#{name}=", value)
  end
end
end