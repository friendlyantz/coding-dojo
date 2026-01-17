# frozen_string_literal: true

# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# Example 1:
# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

# Example 2:
# Input: strs = [""]
# Output: [[""]]

# Example 3:
# Input: strs = ["a"]
# Output: [["a"]]

# Constraints:
#     1 <= strs.length <= 104
#     0 <= strs[i].length <= 100
#     strs[i] consists of lowercase English letters.

def solution(words)
  # create a hash_index of anagram, key would be a sorted chars
  # at the same time populate the hash_index
  # 31ms
  # 217.14MB
  anagram_index = Hash.new { |h, k| h[k] = [] }
  words
    .each do |word|
      anagram_key = word.chars.sort.join

      anagram_index[anagram_key] << word
    end

  anagram_index.values
end

# 25ms
def solution_with_builtin_group_by(words)
  words.group_by { |word| word.chars.sort.join }.values
end

# 49ms
def solution_with_builtin_group_by_and_char_freq(words)
  words.group_by do |word|
    # alpabet array with default value
    char_freq = Array.new(26, 0)
    word.each_char { |char| char_freq[char.ord - "a".ord] += 1 }
    char_freq
  end.values
end


RSpec.describe "Solution" do
  let(:input_one) { ["eat", "tea", "tan", "ate", "nat", "bat"] }
  let(:input_two) { [""] }
  let(:input_three) { ["a"] }

  it "returns incremented big num as an array of digits" do
    expect(solution(input_one)).to eq([["eat", "tea", "ate"], ["tan", "nat"], ["bat"]])
    expect(solution(input_two)).to eq [[""]]
    expect(solution(input_three)).to eq [["a"]]
  end
end
