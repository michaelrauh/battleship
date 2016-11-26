require 'file_handler'
require 'game_state'
module TrainingAggregator

  def self.trained?
    FileHandler.get_all.count > 1
  end

  def self.aggregate
    model = Array.new(100, 0)
    FileHandler.get_all.each do |filename|
      complete_state = GameState.load(filename).flatten
      complete_state.each_with_index do |state, index|
        if (state == :hit)
          model[index] += 1
        end
      end
    end
    model.each_slice(10).to_a
  end

end
