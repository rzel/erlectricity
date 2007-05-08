module Erlectricity
class MatchContext
  attr_accessor :receiver
  def initialize(receiver)
    self.receiver = receiver
  end
  
  def receive(&block)
    receiver.receive(&block)
  end

  def receive_loop
    receiver.receive_loop
  end
  
  def send!(*term)
    receiver.send!(*term)
  end
end
end