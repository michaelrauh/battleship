require 'file_handler'

describe 'file handler' do

  SNAPSHOTS_DIR = 'snapshots'

  after(:each) do
    FileUtils.rm_rf(SNAPSHOTS_DIR)
  end

  before(:each) do
    Dir.mkdir(SNAPSHOTS_DIR) unless Dir.exist?(SNAPSHOTS_DIR)
  end

  it 'can calculate a safe name for a new snapshot file' do
    expect(FileHandler.get_next).to eq("#{SNAPSHOTS_DIR}/1.yml")
    File.open("#{SNAPSHOTS_DIR}/1.yml", 'w') {|f| f.write "" }
    expect(FileHandler.get_next).to eq("#{SNAPSHOTS_DIR}/2.yml")
  end

  it 'can retrieve all training files' do
    File.open("#{SNAPSHOTS_DIR}/1.yml", 'w') {|f| f.write "" }
    File.open("#{SNAPSHOTS_DIR}/2.yml", 'w') {|f| f.write "" }
    found = FileHandler.get_all
    expected = ["#{SNAPSHOTS_DIR}/1.yml", "#{SNAPSHOTS_DIR}/2.yml"]
    expect(found).to eq expected
  end
end
