require_relative 'color'

class Player

  private

  attr_reader :num

  public

  attr_accessor :name

  def initialize(name, num)
    @name = num == 1 ? name.yellow : name.red
    @num = num
  end

  def first?
    num == 1
  end
end