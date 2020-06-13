class Player

  private

  attr_reader :num

  public

  attr_accessor :name

  def initialize(name, num)
    @name = name
    @num = num
  end

  def first?
    num == 1
  end
end