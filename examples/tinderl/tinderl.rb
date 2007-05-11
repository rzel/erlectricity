require 'rubygems'
require 'erlectricity'
require 'tinder'

domain, email, password, room_name = *ARGV
campfire = Tinder::Campfire.new domain
campfire.login email, password
room = campfire.find_room_by_name room_name

receive do
  match(:speak, any(:comment)) do
    room.speak comment
    receive_loop
  end 
  
  match(:paste, any(:comment)) do
    room.paste comment
    receive_loop
  end
end

room.leave if room
