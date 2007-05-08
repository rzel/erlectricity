$:.unshift(File.dirname(__FILE__) + "/../../lib/")
require 'rubygems'
require 'erlectricity'
require 'gruff'

receive do
  
  
    
  match(:plot, string(:name), atom(:style), string(:font)) do
    graph = Gruff.const_get(style).new
    graph.title = name
    graph.font = font
    graph.legend_font_size = 10
    
    
    receive do
      match(:data, atom(:name), list(:points)) do
        graph.data name, points
        receive_loop
      end
  
      match(:labels, hash(:label_data)) do
        graph.labels = label_data
        receive_loop
      end
  
      match(:end){ :ok }
    end
    
    
    send! :result, graph.to_blob
    receive_loop
  end
    
end


