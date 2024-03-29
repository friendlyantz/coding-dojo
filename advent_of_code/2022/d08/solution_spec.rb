require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }
  let(:tree_map) { TreeMap.new(example_input) }

  describe 'Part 1' do
    #
    #--- Day 8: Treetop Tree House ---

    # The expedition comes across a peculiar patch of tall trees all planted carefully in a grid. The Elves explain that a previous expedition planted these trees as a reforestation effort. Now, they're curious if this would be a good location for a tree house.

    # First, determine whether there is enough tree cover here to keep a tree house hidden. To do this, you need to count the number of trees that are visible from outside the grid when looking directly along a row or column.

    # The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For example:

    # 30373
    # 25512
    # 65332
    # 33549
    # 35390

    # Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

    # A tree is visible if all of the other trees between it and an edge of the grid are shorter than it. Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

    # All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view. In this example, that only leaves the interior nine trees to consider:

    #     The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
    #     The top-middle 5 is visible from the top and right.
    #     The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
    #     The left-middle 5 is visible, but only from the right.
    #     The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
    #     The right-middle 3 is visible from the right.
    #     In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

    # With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

    # Consider your map; how many trees are visible from outside the grid?

    describe 'implementation' do
      it 'generates map with correct heights' do
        result = tree_map.matrix
                         .map { _1.map { |i| i[:value] } }
        expect(result).to eq(
          [[3, 0, 3, 7, 3],
           [2, 5, 5, 1, 2],
           [6, 5, 3, 3, 2],
           [3, 3, 5, 4, 9],
           [3, 5, 3, 9, 0]]
        )
      end

      describe 'scans horizontally' do
        before do
          @tree = tree_map
        end

        it 'scannin from left the line with index 1 marks top left "5" as visible' do
          result = scan_left(1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false],
             [true, true, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false]]
          )
        end

        it 'scannin from right the line with index 1 marks all visible trees' do
          result = scan_right(1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false],
             [false, false, true, false, true],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false]]
          )
        end
        it 'scannin from right the line with index 2 marks all visible trees' do
          result = scan_right(2)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false],
             [false, false, false, false, false],
             [true, true, false, true, true],
             [false, false, false, false, false],
             [false, false, false, false, false]]
          )
        end
      end

      describe 'scans vertically' do
        before do
          @tree = tree_map
        end
        it 'scannin from top the line with index 1 marks correct cells visible' do
          result = scan_top(1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, true, false, false, false],
             [false, true, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false]]
          )
        end

        it 'scannin from top the line with index 3 marks correct cells visible' do
          result = scan_top(3)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, true, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, true, false]]
          )
        end

        it 'scannin from bottom the line with index 1 marks all visible trees' do
          result = scan_bottom(1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, true, false, false, false]]
          )
        end
        it 'scannin from bottom the line with index 2 marks all visible trees' do
          result = scan_bottom(2)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, false, false, false],
             [false, false, true, false, false],
             [false, false, true, false, false]]
          )
        end
      end
    end

    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns correct result' do
          expect(solution_pt1(example_input)).to eq 21
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          expect(solution_pt1(custom_input)).to eq 1829
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # --- Part Two ---

    # Content with the amount of tree cover available, the Elves just need to know the best spot to build their tree house: they would like to be able to see a lot of trees.

    # To measure the viewing distance from a given tree, look up, down, left, and right from that tree; stop if you reach an edge or at the first tree that is the same height or taller than the tree under consideration. (If a tree is right on the edge, at least one of its viewing distances will be zero.)

    # The Elves don't care about distant trees taller than those found by the rules above; the proposed tree house has large eaves to keep it dry, so they wouldn't be able to see higher than the tree house anyway.

    # In the example above, consider the middle 5 in the second row:

    # 30373
    # 25512
    # 65332
    # 33549
    # 35390

    #     Looking up, its view is not blocked; it can see 1 tree (of height 3).
    #     Looking left, its view is blocked immediately; it can see only 1 tree (of height 5, right next to it).
    #     Looking right, its view is not blocked; it can see 2 trees.
    #     Looking down, its view is blocked eventually; it can see 2 trees (one of height 3, then the tree of height 5 that blocks its view).

    # A tree's scenic score is found by multiplying together its viewing distance in each of the four directions. For this tree, this is 4 (found by multiplying 1 * 1 * 2 * 2).

    # However, you can do even better: consider the tree of height 5 in the middle of the fourth row:

    # 30373
    # 25512
    # 65332
    # 33549
    # 35390

    #     Looking up, its view is blocked at 2 trees (by another tree with a height of 5).
    #     Looking left, its view is not blocked; it can see 2 trees.
    #     Looking down, its view is also not blocked; it can see 1 tree.
    #     Looking right, its view is blocked at 2 trees (by a massive tree of height 9).

    # This tree's scenic score is 8 (2 * 2 * 1 * 2); this is the ideal spot for the tree house.

    # Consider each tree on your map. What is the highest scenic score possible for any tree?

    describe 'implementation' do
      it "calcs scenic score of cell '5' in the top middle" do
        @tree ||= TreeMap.new(example_input)
        expect(scenic_score(1, 2, tree_map)).to eq 4
        expect(scenic_score(3, 2, tree_map)).to eq 8
        expect(scenic_score(1, 3, tree_map)).to eq 1
      end
    end

    context 'example input data' do
      it 'returns correct result' do
        expect(solution_pt2(example_input)).to eq 8
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        expect(solution_pt2(custom_input)).to eq 291840
      end
    end
  end
end
