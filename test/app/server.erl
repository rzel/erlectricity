-module(server).
-export([start/0, stop/0, titleize/1]).

start() -> 
  spawn(fun() -> 
    register(ruby_port, self()), 
    process_flag(trap_exit, true), 
    Port = open_port({spawn, "ruby ./titleizer.rb"}, [{line, 100}, use_stdio, exit_status]), 
    port_loop(Port) 
  end). 

stop() -> ruby_port ! stop. 

titleize(String) -> 
  ruby_port ! {call, self(), String}, 
  receive 
    {titleized, Result} -> Result 
  end. 


port_loop(Port) ->
  receive
    {call, Caller, String} -> 
      io:format("sending to port"),
      Port ! {self(), {command, term_to_binary({titleize, String})}}, 
      io:format("waiting port"),
      receive 
        {Port, {data, Data}} -> 
          Caller ! {titleized, binary_to_term(Data)} 
      end, 
      port_loop(Port); 

    
    stop -> 
      Port ! {self(), close}, 
      receive 
        {Port, closed} -> exit(normal) 
     end; 
    
    {'EXIT', Port, Reason} -> exit({port_terminated,Reason})
  end.
    