module TestHelpers
  def load_data(path)
    File.read(File.join(__dir__, '../', path))
  end
end
