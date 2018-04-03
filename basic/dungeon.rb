#= RDoc Example
#
#== This is a heading
#
#* First item in an outer list
# * First item in an inner list
# * Second item in an inner list
#* Second item in an outer list
# * Only item in this inner list
#
#== This is a second heading
#
#Visit www.rubyinside.com
#
#== Test of text formatting features
#
#Want to see *bold* or _italic_ text? You can even embed
#+text that looks like code+ by surrounding it with plus
#symbols. Indented code will be automatically formatted:
#
# class MyClass
# def method_name
# puts "test"
# end
# end


class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_rooms(reference, name, description, connnections)
    @rooms << Room.new(reference, name, description, connnections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You go #{direction}"
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  class Player
    attr_accessor :name, :location

    def initialize(player_name)
      @name = player_name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in #{description}"
    end
  end
end

my_dungeon = Dungeon.new("Yithak Magoon")
my_dungeon.add_rooms(:largecave, "Large Cave", "a large cavernous cave", { :west => :smallcave })
my_dungeon.add_rooms(:smallcave, "Small Cave", "a small cavernous cave", { :east => :largecave })
#start the dungeon!
my_dungeon.start(:largecave)
my_dungeon.go(:west)
my_dungeon.show_current_description
my_dungeon.go(:east)
