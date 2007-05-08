#!/usr/bin/env ruby
$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'rubygems'
require 'active_support'
require 'erlectricity'

listen do
  receive([pid, :stop]){ throw :exit }
  
  receive([:titleize, string]) do |m, a|
    port! a.titleize
  end
  
end
