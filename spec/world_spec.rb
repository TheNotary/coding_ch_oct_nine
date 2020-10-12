require 'spec_helper'
require "coding_ch_oct_nine/world"

describe CodingChOctNine::World do

  before :each do
    @world = CodingChOctNine::World.new
    @world.x_dimension_length = 7
    @world.y_dimension_length = 7
  end

  it 'can parse a map file' do
    @world.parse_map("../../config/map")

    expect(@world.initial_map_data).not_to be nil
  end

  it 'can process_location_of_pieces' do
    map_data = "XX1X2XX\n-------\n-X0X3Xn\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
    pieces, houses, terrain = @world.process_location_of_pieces_and_houses map_data

    expect(pieces.length).to eq 1
    expect(houses.length).to eq 10
  end

  it 'can identify pieces' do
    expect(@world.identify_object('n')).to be :backward_tricker_treater
    expect(@world.identify_object('p')).to be :forward_tricker_treater
    expect(@world.identify_object('-')).to be :open_space
    expect(@world.identify_object('X')).to be :terrain
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

  it "can draw the higgs field" do
    # @world = CodingChOctNine::World.new("../../config/map")
    expected_field = create_test_higgs
    higgs_field = @world.draw_higgs_field

    expect(higgs_field).to eq expected_field
  end

  it "can draw the houses" do
    state = create_test_higgs
    house_data = [
      { x: 1, y: 0,
        char: '0',
        kind: :house },
      { x: 2, y: 0,
        char: '1',
        kind: :house }
    ]

    state = @world.draw_in_houses(state, house_data)
    expect(state.join).to eq "-01----------------------------------------------"
  end



  it "can draw in tricker_treaters" do
    state = create_test_higgs
    piece_data = [
      { x: 1, y: 0,
        char: 'p',
        kind: :forward_tricker_treater,
        life: 0,
        ticks_before_next_move: 0,
        visitations: [] },
      { x: 2, y: 0,
        char: 'n',
        kind: :backward_tricker_treater,
        life: 0,
        ticks_before_next_move: 0,
        visitations: [] },
      { x: 3, y: 0,
        char: 'y',
        kind: :you,
        life: 0,
        ticks_before_next_move: 0,
        visitations: [] }
    ]

    state = @world.draw_in_moving_pieces(state, piece_data)

    expect(state.join).to eq "-pny---------------------------------------------"
  end

  it "can print it's state based on the parsed data from the initial map" do
    @world = CodingChOctNine::World.new("../../config/map")

    expect(@world.print_state).to eq "XX1X2XX\n-------\n-X0X3Xn\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
  end

  it 'can tick the world moving tricker_treaters' do
    @world = CodingChOctNine::World.new("../../config/map")

    initial_state = @world.print_state
    sequential_state = @world.tick!
    expect(sequential_state).to eq "XX1X2XX\n------n\n-X0X3X-\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
    sequential_state = @world.tick!
    expect(sequential_state).to eq "XX1X2XX\n-----n-\n-X0X3X-\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
    sequential_state = @world.tick!
    expect(sequential_state).to eq "XX1X2XX\n----n--\n-X0X3X-\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
    sequential_state = @world.tick!
    expect(sequential_state).to eq "XX1X2XX\n-------\n-X0XnX-\n-9XXX4-\n-X8X6X-\n-------\nXX7X5XX\n"
  end

  it "can calculate_adjacent_points" do
    state = create_test_higgs

    obj = {x: 6, y: 2}
    a_points = @world.calculate_adjacent_points(obj)
    expect(a_points.count).to eq 3

    obj = {x: 0, y: 0}
    a_points = @world.calculate_adjacent_points(obj)
    expect(a_points.count).to eq 2

    obj = {x: 6, y: 6}
    a_points = @world.calculate_adjacent_points(obj)
    expect(a_points.count).to eq 2

    obj = {x: 3, y: 3}
    a_points = @world.calculate_adjacent_points(obj)

    expect(a_points.count).to eq 4
  end

  it 'it can generate paths from a point to nearby houses' do
    @world = CodingChOctNine::World.new("../../config/map")

    paths = @world.build_paths_to_destinations(obj)

    # expect(houses.count).to eq 4
  end



  # it 'can search adjacent houses' do
  #   @world = CodingChOctNine::World.new("../../config/map")
  #
  #   adj_points = [{:x=>3, :y=>2}, {:x=>4, :y=>3}, {:x=>3, :y=>4}, {:x=>2, :y=>3}]
  #   houses = @world.filter_houses(adj_points)
  #
  #   expect(houses.count).to eq 4
  # end

  # it 'can determine the shortest path to a destination' do
  # end

end
