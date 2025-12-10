class Complement
  DICT = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }.freeze

  def self.of_dna(dna)
    dna.chars.map { |char| DICT[char] }.join
  end
end
