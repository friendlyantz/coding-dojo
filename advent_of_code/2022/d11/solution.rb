require 'json'
require 'ruby-progressbar'

def solution_pt1(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| genrate_moneys_from(data) }
    .then { play_rounds(20) }
    .then { calc_monkey_business }
end

def solution_pt2(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| genrate_moneys_from(data) }
    .then { play_rounds(10_000, false) }
    .then { calc_monkey_business }
end

class Monkey
  attr_reader :id, :items, :divisible_by, :operation
  attr_accessor :if_true, :if_false, :inspections_counter

  def initialize(id:, items:, operation:, divisible_by:, if_true:, if_false:)
    @id = id
    @items = items
    @operation = operation
    @divisible_by = divisible_by
    @if_true = if_true
    @if_false = if_false
    @inspections_counter = 0
  end
end

def prep_data(data)
  data.split("\n\n").map { _1.lines.map(&:chomp) }
end

def monkeys
  @monkeys ||= []
end

def worry_level
  @worry_level ||= 0
end

def genrate_moneys_from(data)
  data.map.with_index do |group, i|
    monkeys << Monkey.new(
      id: i,
      items: group[1].scan(/\d+/).map(&:to_i),
      operation: write_down(group[2]),
      divisible_by: group[3].scan(/\d+/).first.to_i,
      if_true: group[4].scan(/\d+/).first.to_i,
      if_false: group[5].scan(/\d+/).first.to_i
    )
  end

  map_monkey_to_monkey(monkeys)
end

def play_rounds(qty, div_by_three = true)
  progress = ProgressBar.create(total: qty)
  qty.times do
    monkeys.each do |monkey|
      throw_items_of(monkey, div_by_three)
    end
    progress.increment
  end
end

def calc_monkey_business
  monkeys
    .map { |monkey| monkey.inspections_counter }
    .sort
    .reverse[0..1]
    .inject(:*)
end

def throw_items_of(monkey, div_by_three)
  while monkey.items.any?
    monkey.inspections_counter += 1
    item = monkey.items.shift

    operators = interpret(monkey.operation, item)
    item = exec(operators)
    if div_by_three
      stabilised_stress = item / 3
      item = stabilised_stress
    else
      largest_common_denominator = monkeys.map(&:divisible_by).reduce(:lcm)
      # https://docs.ruby-lang.org/en/2.1.0/Integer.html#method-i-lcm

      item = item % largest_common_denominator
    end

    if item.modulo(monkey.divisible_by).zero?
      monkey.if_true.items << item
    else
      monkey.if_false.items << item
    end
  end
end

def exec(operators)
  operators[0].send(operators[1], operators[2])
end

def interpret(operation, item)
  operation
    .map do |op|
      if op == 'old'
        op = item
      elsif op[/\d+/]
        op.to_i
      elsif op[%r{[+|*|-|/]}]
        op.to_sym
      end
    end
end

def write_down(operation)
  operation
    .scan(%r{(old|[+|*|-|/]|\d+)})
    .flatten
end

def map_monkey_to_monkey(monkeys)
  monkeys.each_with_index do |monkey, _i|
    monkey.if_true = monkeys.find { _1.id == monkey.if_true }
    monkey.if_false = monkeys.find { _1.id == monkey.if_false }
  end
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
  puts solution_pt2(input)
end
