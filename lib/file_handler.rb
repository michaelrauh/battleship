module FileHandler
  SNAPSHOTS_DIR = 'snapshots'
  def self.get_next
    Dir.mkdir(SNAPSHOTS_DIR) unless Dir.exist?(SNAPSHOTS_DIR)
    most_recent_file = Dir["#{SNAPSHOTS_DIR}/*.yml"].sort.last
    if most_recent_file
      current_file = "#{SNAPSHOTS_DIR}/#{most_recent_file.match(/\d+/)[0].to_i + 1}.yml"
    else
      current_file = "#{SNAPSHOTS_DIR}/1.yml"
    end
      current_file
  end

  def self.get_all
    Dir["#{SNAPSHOTS_DIR}/*.yml"].sort
  end
end
