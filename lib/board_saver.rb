require 'file_handler'
require 'game_state'

class BoardSaver
include FileHandler
include GameState

  def initialize
    @snapshot_file_name = FileHandler.get_next
  end

  def update(state)
    GameState.write(@snapshot_file_name, state)
  end
end
