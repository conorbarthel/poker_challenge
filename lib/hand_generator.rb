class HandGenerator
  def initialize(filename)
    @filename = File.open(filename)
  end

  def hands
    file_data = File.read(@filename).split("\n")
    hands = []
    file_data.each do |line|
      card = line.split(" ")
      deal = card[0..9]
      hands << deal
    end
    hands
  end
end
