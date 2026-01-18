# frozen_string_literal: true

# Given an integer array nums and an integer k,
# return the k most frequent elements.
# You may return the answer in any order.

# Example 1:
# Input: nums = [1,1,1,2,2,3], k = 2
# Output: [1,2]

# Example 2:
# Input: nums = [1], k = 1
# Output: [1]

# Constraints:
#     1 <= nums.length <= 105
#     -104 <= nums[i] <= 104
#     k is in the range [1, the number of unique elements in the array].
#     It is guaranteed that the answer is unique.

def solution(nums, k)
  built_in_ruby(nums, k)
  # manual_solution(nums, k)
end

# 0ms Beats100.00%
# Memory 212.38MB Beats88.20%
def built_in_ruby(nums, k)
  nums.tally
    .sort_by { |_, count| -count }
    .first(k)
    .map(&:first)
end

# 11ms Beats49.69%
# 212.28MB Beats98.76%
def manual_solution(nums, k)
  index = Hash.new { |h, key| h[key] = 0 }
  nums.each { |e| index[e] += 1 }

  index
    .sort_by { |_, count| -count }
    .first(k)
    .map(&:first)
end

RSpec.describe "Solution" do
  let(:input_one) { [1, 1, 1, 2, 2, 3] }
  let(:k_one) { 2 }
  let(:input_two) { [1] }
  let(:k_two) { 1 }

  it "returns incremented big num as an array of digits" do
    expect(solution(input_one, k_one)).to eq([1, 2])
    expect(solution(input_two, k_two)).to eq [1]
  end
end
