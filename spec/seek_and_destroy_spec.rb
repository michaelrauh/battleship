require 'spec_helper'
require 'fileutils'
require_relative '../players/seek_and_destroy'

describe 'player seek and destroy' do

  let(:seek_and_destroy) { SeekAndDestroy.new }

  after(:each) do
    FileUtils.rm_rf('snapshots')
  end

  let(:state){
    state = []
    10.times do |row|
      column = []
      10.times do |thing|
        column << :unknown
      end
      state << column
    end
    state
  }

  let(:ships_remaining){
    [5, 4, 3, 3, 2]
  }

  it 'attacks randomly when untrained' do
    class SeekAndDestroy
      def random_hit
        [5, 5]
      end
    end
    seek_and_destroy.new_game

    coord = seek_and_destroy.take_turn(state, ships_remaining)
    expect(coord).to eq [5, 5]
  end

  it 'attacks most hit spot when trained' do
    old_state = state.dup
    old_state[0][0] = :hit
    GameState.write('snapshots/1.yml', old_state)
    seek_and_destroy.new_game
    coord = seek_and_destroy.take_turn(state, ships_remaining)
    expect(coord).to eq [0,0]
  end

  it 'aggregates across games to determine the most hit spot' do
    state[2][2] = :hit
    GameState.write('snapshots/1.yml', state)
    state[0][1] = :hit
    GameState.write('snapshots/2.yml', state)
    seek_and_destroy.new_game
    coord = seek_and_destroy.take_turn(state, ships_remaining)
    expect(coord).to eq [2,2]
  end

end
