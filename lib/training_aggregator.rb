require 'file_handler'
module TrainingAggregator

  def self.trained?
    FileHandler.get_all.count > 1
  end
end
