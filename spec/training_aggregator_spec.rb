require 'training_aggregator'

describe 'training aggregator' do
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
end
