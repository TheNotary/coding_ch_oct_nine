require 'fileutils'

module CodingChOctNine
  class World

    attr_accessor :map_data, :piece_data, :house_data

    def initialize(relative_path_to_map_data = nil)
      initialize_state_from_map_data(relative_path_to_map_data) if (relative_path_to_map_data)
    end

    def initialize_state_from_map_data(relative_path_to_map_data)
      @map_data = parse_map(relative_path_to_map_data)
      @piece_data, @house_data = process_location_of_pieces_and_houses(@map_data)
    end

    # Make the world tick forward
    def tick
      @piece_data.each do |piece|
        perform_tick_for_piece!(piece)
      end
    end

    # Reads a map.  Each character in a line represents a geometric point.
    # where newlines indicate the ending of a dimension along that axis (y)
    # T- == n
    # T+ == p
    def parse_map(relative_path_to_map_data)
      @map_data = File.read("#{File.dirname(__FILE__)}/#{relative_path_to_map_data}")
    end

    def print_state
      @map_data
    end

    # Removes location of pieces from map_data and puts it in piece_data
    def process_location_of_pieces_and_houses(map_data)
      piece_data = []
      house_data = []

      map_data.each_line.with_index do |map_line, y|
        map_line.chomp!

        map_line.split('').each.with_index do |char, x|

          # TODO: Check if the object exists, if it doesn't, then create it first time here
          obj = { x: x, y: y, life: 0,
                  char: char,
                  kind: identify_object(char),
                  ticks_before_next_move: 0,
                  visitations: [] }

          if obj[:kind] == :forward_tricker_treater ||
             obj[:kind] == :backward_tricker_treater
            momentum = obj[:kind] == :backward_tricker_treater ? -1 : 1
            obj.merge!(momentum: momentum)
            obj.merge!(destination: determine_destination(obj))
            obj.merge!(path: determine_path_to_destination(obj))
            piece_data << obj
          elsif obj[:kind] == :house
            house_data << obj
          end
        end
      end

      [piece_data, house_data]
    end

    def identify_object(char)
      case char.downcase
      when 'p'
        :forward_tricker_treater
      when 'n'
        :backward_tricker_treater
      when '-'
        :open_space
      when 'x'
        :obstacle
      when 'y'
        :you
      else
        :house
      end
    end

    # Determines what house the object will visit next
    def determine_destination(obj)
      #FIXME I AM A STUB!
      3
    end

    def determine_path_to_destination(obj)
      #FIXME I AM A STUB!
      [
        {x: 6, y: 1},
        {x: 5, y: 1},
        {x: 4, y: 1},
        {x: 4, y: 2}
      ]
    end

    def perform_tick_for_piece!(piece)
      piece[:life] += 1
      # When we're visiting a house, we'll have ticks to burn down before we can move
      if piece[:ticks_before_next_move] > 0
        perform_tick_burndown_for_piece!(piece)
      else
        # Otherwise we perform a movement
        perform_movement_for_piece!(piece)
      end
    end

    def perform_tick_burndown_for_piece!(piece)
      piece[:ticks_before_next_move] -= 1
      return
    end

    def perform_movement_for_piece!(piece)
      destination_point = piece[:path].shift
      piece[:x] = destination_point[:x]
      piece[:y] = destination_point[:y]
    end

    #  Looks up what piece/ terrain exists at a point
    def identify_point(x,y)

    end

    def conduct_movement(piece)

    end

  end
end
