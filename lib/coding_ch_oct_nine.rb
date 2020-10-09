require "coding_ch_oct_nine/version"
require "coding_ch_oct_nine/world"

require 'pry'

module CodingChOctNine

  def self.main
    world = World.new
    world.parse_map("../../config/map")
  end

end
