require 'pry'

class Dictionary
  attr_accessor :combinations

  def initialize
    possible_digits = (0..9).to_a
    @combinations = ('A'..'Z').map { |l| [l, possible_digits] }.to_h
  end
end

class Alphametics
  def self.combinations
    @combinations ||= Dictionary.new.combinations
  end

  def self.solve(input)
    separte_operands(input)
      .then do |data|
      validate(data)
      data
    end
      .then do |data|
      filter_out_zeroes(data)
      clean_up_combinations(data)
      data
    end
      .then do |_operands, _sum|
        combinations.each do |key, values|
          values.each do |digit|
            c = combinations.dup
            c.each do
              filter_out_duplicates(c, key, digit)
            end
          end
        end
      end
  end

  def self.filter_out_duplicates(hash, key, digit)
    hash.each do |k, v|
      if k == key
        hash[k] = [digit]
        next
      end
      hash[k] = v - [digit]
    end
  end

  def self.validate(data)
    operands, sum = data
    raise ArgumentError if operands.any? { |operand| operand.size > sum.size }
  end

  def self.separte_operands(input)
    operands = input.scan(/([A-Z]+)/).flatten
    sum = operands.pop
    [operands, sum]
  end

  def self.filter_out_zeroes(data)
    data.flatten.map(&:chr).uniq
        .each do |char|
      combinations[char].delete 0
    end
  end

  def self.clean_up_combinations(data)
    keys = data.flatten.map(&:chars).flatten.uniq
    combinations.keep_if { |k, _| keys.include?(k) }
  end
end
