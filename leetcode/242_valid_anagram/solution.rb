# Given two strings s and t, return true if t is an anagram of s, and false otherwise.

# Example 1:

# Input: s = "anagram", t = "nagaram"
# Output: true

# Example 2:

# Input: s = "rat", t = "car"
# Output: false

def solution(input)
  # sort_solution(input)
  # o1_space_solution(input)
  tally_solution(input)
end

# SORT: time O(n for each word * log(n) Ruby's quicksort algo) or n^2
# SPACE: O(n)
def sort_solution(words)
  words
    .map! { |word| word.chars.sort.join } # sort
    .then { |words| return false if words.first != words.last } # loop though chars or just compare

  true
  # return false if deviation. otherwise true at the end
end

# Space O(1) Space Approach - Character Counting
# Time: O(n)
# Use a fixed-size array (26 slots for 'a'-'z'):
def o1_space_solution(words)
  return false if words.first.length != words.last.length

  counts = Array.new(26, 0)

  # Increment for first word, decrement for second
  words.first.each_char { |c| counts[c.ord - "a".ord] += 1 }
  words.last.each_char { |c| counts[c.ord - "a".ord] -= 1 }

  # Check all counts are zero
  counts.all?(&:zero?)
end

# Ruby's built in tally with fast C implementation
def tally_solution(words) # time O(n) space O(n)
  words.first.chars.tally == words.last.chars.tally
end

RSpec.describe "Solution" do
  let(:input_one) { ["anagram", "nagaram"] }
  let(:input_two) { ["rat", "car"] }
  it "return true for double up values and false if all unique" do
    expect(solution(input_one)).to eq true
    expect(solution(input_two)).to eq false
  end
end
