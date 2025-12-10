module Hamming
  module_function

  def compute(strand1, strand2)
    raise ArgumentError, 'Strands must be the same length' if strand1.length != strand2.length

    strand1.chars
           .zip(strand2.chars)
           .count { |a, b| a != b }
  end
end
