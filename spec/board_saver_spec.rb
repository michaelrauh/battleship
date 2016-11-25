require 'board_saver'

describe 'board saver' do

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

  after(:each) do
    FileUtils.rm_rf(SNAPSHOTS_DIR)
  end

  it 'can be used to save a snapshot by calling update' do
    board_saver = BoardSaver.new
    board_saver.update(state)
    new_state = GameState.load('snapshots/1.yml')
    expect(state).to eq(new_state)
  end
end
