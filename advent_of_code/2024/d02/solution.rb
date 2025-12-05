# frozen_string_literal: true

class Solution
  def initialize(input)
    @input = input
  end

  def solution_pt1
    @input.lines.map(&:strip).map(&:split)
          .map { |data| data.map(&:to_i) }
          .map do |line|
            next unless line == line.sort || line == line.sort.reverse

            case line
            when line.sort
                line.each_cons(2).all? { |b, a| a - b <= 3 && a - b >= 1 }
            when line.sort.reverse
                line.each_cons(2).all? { |a, b| a - b <= 3 && a - b >= 1 }
            end
          end
          .then { |data| data.tally[true] }
  end

  def solution_pt2
    @input.lines.map(&:strip).map(&:split)
          .map { |data| data.map(&:to_i) }
          .map do |line|
            if line.first < line.last
                limiter = 1
                a
                binding.irb
                line.size - count <= 1
            elsif line.first > line.last
                count = line.each_cons(2).count { |a, b| a - b <= 3 && a - b >= 1 }
                line.size - count <= 1
            end
          end
          .then do |data|
      binding.irb
                         data.tally[true]
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
