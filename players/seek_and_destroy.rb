require 'yaml'
require_relative '../lib/game_state'
require 'board_saver'
require 'training_aggregator'

class SeekAndDestroy

  SNAPSHOTS_DIR = "snapshots"

  def name
    "Seek and Destroy"
  end

  def setup_training
    @board_saver = BoardSaver.new
  end

  def build_model
    model = Array.new(100, 0)
    Dir["#{SNAPSHOTS_DIR}/*.yml"].each do |filename|
      complete_state = GameState.load(filename).flatten
      complete_state.each_with_index do |state, index|
        if (state == :hit)
          model[index] += 1
        end
      end
    end
    model
  end

  def update_model(state)
    @board_saver.update(state)
  end

  def model_trained
    TrainingAggregator.trained?
  end

  def initial_ship_positions
    [
      [0, 0, 5, :across],
      [0, 1, 4, :across],
      [0, 2, 3, :across],
      [0, 3, 3, :across],
      [0, 4, 2, :across]
    ]
  end

  def new_game
    setup_training
    initial_ship_positions
  end

  def take_turn(state, ships_remaining)
    update_model(state)
    if model_trained
      model = build_model
      return unflatten(model.each_with_index.max[1])
    else
      random_hit
    end
  end

  def unflatten(index)
    row = index/10
    column = index % 10
    [row, column]
  end

  def random_hit
    [rand(10), rand(10)]
  end
end
