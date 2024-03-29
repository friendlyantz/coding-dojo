# frozen_string_literal: true

class Solution
  def initialize(input)
    @input = input
  end

  def solution_pt1
    # input
  end

  def solution_pt2
    # input
    # .then { |data| binding.pry }
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts Solution.new(input).solution_pt1

  puts '==============='
  puts 'part 2 solution'
  puts Solution.new(input).solution_pt2
end
