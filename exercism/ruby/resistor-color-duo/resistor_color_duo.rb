require_relative 'resistor'

class ResistorColorDuo
  include Resistor

  DISPLAY = '%<tens>s%<ones>s'

  def self.value(colors)
    new(colors).to_i
  end

  private

  attr_reader :value

  def initialize(color_pair)
    first_color, second_color = color_pair
    @value = DISPLAY % { tens: BAND[first_color], ones: BAND[second_color] }
  end

  public

  def to_s
    value
  end

  def to_i
    value.to_i
  end
end
