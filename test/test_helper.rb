$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'test/unit'
require 'test/spec'
require 'erlectricity'

class Test::Unit::TestCase
  
  def run_erl(code)
    `erl -noshell -eval 'A = #{code.split.join(' ')}, io:put_chars(A).' -s erlang halt`
  end
  
  def word_length
    (1.size * 8) - 2
  end
end

class FakePort < Erlectricity::Port
  attr_reader :sent
  attr_reader :terms
  
  def initialize(*terms)
    @terms = terms
    @sent = []
    super(StringIO.new(""), StringIO.new(""))
  end

  def send(term)
    sent << term
  end
  
  private
  def read_from_input
    @terms.shift
  end
end