# frozen_string_literal: true

require 'pry'
require 'pqueue' # https://en.wikipedia.org/wiki/Priority_queue#Dijkstra's_algorithm
require 'set'

require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_yield_lateral')
require File.join(__dir__, '../lib/visualisation.rb')

class SolutionOne
  attr_reader :start, :finish, :alt_map
  attr_accessor :nav_map, :heap

  def initialize(input)
    @nav_map = [] # map with explored path
    generate_nav_map(input)
    @alt_map = [] # map with altitudes
    generate_alt_map
    @start = [0, 0]
    @finish = [0, 0]
    set_start_and_finish

    @heap = PQueue.new([[@start, trail_length = 0]]) do |a, b|
      a.last < b.last
    end
  end

  def generate_nav_map(input)
    input.lines do |line|
      nav_map << line.chomp.chars
    end
  end

  def generate_alt_map
    nav_map.each do |line|
      alt_map <<
        line.map do |x|
          case x
          when 'S' then 0
          when 'E' then 27 # 'z' is 26 in our case
          else          x.ord - 96
          end
        end
    end
  end

  def set_start_and_finish
    alt_map.each_with_index do |x, idx|
      x.each_with_index do |alt, idy|
        @finish = [idx, idy] if alt == 27
        @start = [idx, idy] if alt.zero?
      end
    end
  end

  def run
    dijkstra
  end

  def dijkstra
    visited_set = Set.new

    until heap.empty?
      current_position, trail_length = heap.pop

      next unless visited_set.add?(current_position)

      x, y = current_position

      current_alt = alt_map[x][y]
      return trail_length if current_alt == 27

      nav_map[x][y] = '#'
      print(nav_map)

      NeighbourYieldLateral.all(alt_map, current_position) do |dx, dy|
        alt = alt_map[dx][dy] || 30
        heap.push([[dx, dy], trail_length + 1]) if alt - current_alt <= 1 || (current_alt == 25 && alt == 27)
      end
    end

    nav_map[x][y] = (alt_map[x][y] + 96).chr # cleanup '#' visited marker when coming back
    print(nav_map)
  end

  def print(nav_map)
    return unless __FILE__ == $PROGRAM_NAME

    Visualisation.print_grid(
      nav_map,
      centre_x: 21, centre_y: 35, x_dim: 42, y_dim: 170,
      # sleep: 0.01,
      spacer: ' ',
      colour_char: '#', colour: :red
    )
  end
end

def solution_pt1(input)
  SolutionOne.new(input).run
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  # puts solution_pt2(input)
end
