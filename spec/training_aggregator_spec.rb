require 'training_aggregator'
require 'board_saver'

describe 'training aggregator' do

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

  SNAPSHOTS_DIR = 'snapshots'

  after(:each) do
    FileUtils.rm_rf(SNAPSHOTS_DIR)
  end

  before(:each) do
    Dir.mkdir(SNAPSHOTS_DIR) unless Dir.exist?(SNAPSHOTS_DIR)
  end

  it 'can report when a player is trained' do
    expect(TrainingAggregator.trained?).to eq false
    File.open("#{SNAPSHOTS_DIR}/1.yml", 'w') {|f| f.write "" }
    expect(TrainingAggregator.trained?).to eq false
    File.open("#{SNAPSHOTS_DIR}/2.yml", 'w') {|f| f.write "" }
    expect(TrainingAggregator.trained?).to eq true
  end

  it 'can produce an aggregate of all training expressed as a count of hits for each coordinate' do
    board_saver = BoardSaver.new
    state[0][0] = :hit
    board_saver.update(state)
    state[0][1] = :hit
    new_board_saver = BoardSaver.new
    new_board_saver.update(state)
    found = TrainingAggregator.aggregate
    expected = []
    10.times do |row|
      column = []
      10.times do |thing|
        column << 0
      end
      expected << column
    end
    expected[0][0] = 2
    expected[0][1] = 1
    expect(found).to eq expected

  end
end
