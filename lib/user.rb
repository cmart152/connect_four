class User
  attr_reader :name
  attr_accessor :score
  attr_reader :piece
  def initialize(name, piece)
    @name = name
    @score = 0
    @piece = piece
  end
end