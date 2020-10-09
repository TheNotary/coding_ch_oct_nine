require 'spec_helper'
require "coding_ch_oct_nine/world"

describe CodingChOctNine::World do
  it 'world can parse a map file' do
    world = CodingChOctNine::World.new
    world.parse_map("../../config/map")

    expect(world.map_data).not_to be nil
  end
end
