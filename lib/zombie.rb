class Zombie
  attr_reader :name , :brains

  def initialize
    @name = "Ash"
    @brains = 0
  end

  def hungry?
    true
  end

end
