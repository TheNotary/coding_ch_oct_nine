require 'spec_helper'
require "coding_ch_oct_nine/world"

describe CodingChOctNine::World do

  before :each do
    @world = CodingChOctNine::World.new
  end

  it 'can parse a map file' do
    @world.parse_map("../../config/map")

    expect(@world.map_data).not_to be nil
  end

  it 'can process_location_of_pieces' do
    map_data = "XX1X2XX\n-------\n-X0X3Xn\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
    pieces, houses = @world.process_location_of_pieces_and_houses map_data

    expect(pieces.length).to eq 1
    expect(houses.length).to eq 10
  end

  it 'can identify pieces' do
    expect(@world.identify_object('n')).to be :backward_tricker_treater
    expect(@world.identify_object('p')).to be :forward_tricker_treater
    expect(@world.identify_object('-')).to be :open_space
    expect(@world.identify_object('X')).to be :obstacle
    expect(@world.identify_object('0')).to be :house
    expect(@world.identify_object('9')).to be :house
    expect(@world.identify_object('y')).to be :you
  end

  it "can have it's pieces tick, moving on the board" do
    piece = { x: 4, y: 4,
      life: 0,
      ticks_before_next_move: 0,
      path: [ {x: 4, y: 3} ] }
    @world.perform_tick_for_piece!(piece)
    expect(piece[:x]).to be 4
  end

  it 'can tick the world moving tricker_treaters' do
    @world = CodingChOctNine::World.new("../../config/map")

    initial_state = @world.print_state
    @world.tick
    sequential_state = @world.print_state
    expect(sequential_state).to eq "XX1X2XX\n------n\n-X0X3X-\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
  end

end
