# frozen_string_literal: true

class Solution
  def initialize(input)
    @input = input
  end

  def solution_pt1
    @input.lines.map(&:strip)
          .map(&:split)
          .map { |a, b| [a.to_i, b.to_i] }
          .then do |data|
            l_column = data.map(&:first).sort
            r_column = data.map(&:last).sort
            l_column.zip(r_column).sum { |l, r| (l - r).abs }
    end
  end

  def solution_pt2
    @input.lines.map(&:strip)
          .map(&:split)
          .map { |a, b| [a.to_i, b.to_i] }
          .then do |data|
            l_column = data.map(&:first).sort
            r_column = data.map(&:last).sort
            l_column.sum do |l_num|
              r_column.tally[l_num].nil? ? 0 : r_column.tally[l_num] * l_num
            end
    end
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
