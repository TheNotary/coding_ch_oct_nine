require 'fileutils'

module CodingChOctNine
  class World

    attr_accessor :map_data, :piece_data

    # Reads a map.  Each character in a line represents a geometric point.
    # where newlines indicate the ending of a dimension along that axis (y)
    # T- == n
    # T+ == p
    def parse_map(relative_path)
      @map_data = File.read("#{File.dirname(__FILE__)}/#{relative_path}")
      @piece_data = process_location_of_pieces(@map_data)


      binding.pry
    end

    def print
      puts @map_data
    end

    # Removes location of pieces from map_data and puts it in piece_data
    def process_location_of_pieces(map_data)
      peice_data = []

      # map_data.each_line |map_line| do
      #   map_line.each |map_point| do
      #     puts map_point
      #   end
      # end

      return peice_data
    end

    def conduct_movement(piece)

    end

  end
end
