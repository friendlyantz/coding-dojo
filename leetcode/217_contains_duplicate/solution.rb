# frozen_string_literal: true

# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

# Example 1:

# Input: nums = [1,2,3,1]
# Output: true

# Example 2:

# Input: nums = [1,2,3,4]
# Output: false

# Example 3:

# Input: nums = [1,1,1,3,3,4,3,2,4,2]
# Output: true

# Constraints:

#     1 <= nums.length <= 105
#     -109 <= nums[i] <= 109

def contains_duplicate(nums)
  # hash_set(nums)
  sorting_approach(nums)
  # naive_builtin_method_solution(nums)

end

# BEST SOLUTION: Hash Set Approach
# Time: O(n), Space: O(n)
# Use a hash set to track seen numbers. If we encounter a number already in the set, return true.
# This is optimal because hash lookups are O(1) average case.
def hash_set(nums)
  set = Set.new
  nums.each do |e|
    # check  if it is exists O(n)
    return true if set.include?(e)
    # if not seen -> add to resuts array or circuit break
    set.add e
  end
  false
end

# ALTERNATIVE: Sorting Approach: Slower, but more space efficient but slower.
# Time: O(n log n), Space: O(1) or O(n) depending on sort implementation
# Sort the array, then check adjacent elements.
def sorting_approach(nums)
  nums.sort!
  (1...nums.length).each do |i|
    pointer  = nums[i]
    previous_value = nums[i - 1]
    return true if pointer.eql? previous_value
  end
  false
end

# SIMPLE BUT LESS EFFICIENT: Built-in methods
# Uses Ruby's uniq which also uses hash table internally, but creates full new array
def naive_builtin_method_solution
  # nums.tally.any? { |_k, v| v > 1 }
  nums.uniq != nums
end

RSpec.describe "Solution" do
  let(:input_one) { [1, 1, 1, 3, 3, 4, 3, 2, 4, 2] }
  let(:input_two) { [1, 2, 3, 4] }
  it "return true for double up values and false if all unique" do
    expect(contains_duplicate(input_one)).to eq true
    expect(contains_duplicate(input_two)).to eq false
  end
end
