class Garden
  DICTIONARY = {
    'V' => :violets,
    'R' => :radishes,
    'C' => :clover,
    'G' => :grass
  }.freeze

  NAME_MAP = {
    alice: 0..1,
    bob: 2..3,
    charlie: 4..5,
    david: 6..7,
    eve: 8..9,
    fred: 10..11,
    ginny: 12..13,
    harriet: 14..15,
    ileana: 16..17,
    joseph: 18..19,
    kincaid: 20..21,
    larry: 22..23
  }.freeze.each do |name, range|
    define_method(name) { parsed_input(range) }
  end

  def initialize(input)
    @input = input
  end

  private

  def parsed_input(range)
    @input
      .lines
      .map(&:strip)
      .map { |line| line[range].chars }
      .map { |array| array.map { DICTIONARY[_1] } }
      .flatten
  end
end
