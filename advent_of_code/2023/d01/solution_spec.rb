# frozen_string_literal: true

require 'pry'
require 'awesome_print'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.setup
RSpec.describe Solution do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    #
    # --- Day 1: Trebuchet?! ---
    #
    # Something is wrong with global snow production, and you've been selected to take a look. The Elves have even given you a map; on it, they've used stars to mark the top fifty locations that are likely to be having problems.
    #
    # You've been doing this long enough to know that to restore snow operations, you need to check all fifty stars by December 25th.
    #
    # Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
    #
    # You try to ask why they can't just use a weather machine ("not powerful enough") and where they're even sending you ("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on did you just say the sky ("of course, where do you think snow comes from") when you realize that the Elves are already loading you into a trebuchet ("please hold still, we need to strap you in").
    #
    # As they're making the final adjustments, they discover that their calibration document (your puzzle input) has been amended by a very young Elf who was apparently just excited to show off her art skills. Consequently, the Elves are having trouble reading the values on the document.
    #
    # The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.
    #
    # For example:
    #
    # 1abc2
    # pqr3stu8vwx
    # a1b2c3d4e5f
    # treb7uchet
    #
    # In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
    #
    # Consider your entire calibration document. What is the sum of all of the calibration values?
    #

    describe 'implementation' do
      it 'calibration values are correct for each line' do
        expect(LineCalibrator.new('1abc2').call).to eq 12
        expect(LineCalibrator.new('pqr3stu8vwx').call).to eq 38
        expect(LineCalibrator.new('a1b2c3d4e5f').call).to eq 15
        expect(LineCalibrator.new('treb7uchet').call).to eq 77
      end
    end

    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns sum of lines' do
          expect(Solution.new.solution_pt1(example_input)).to eq 142
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          expect(Solution.new.solution_pt1(custom_input)).to eq 55_477
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # DESCRIPTION Part 2
    #
    context 'example input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(example_input)).to eq true
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(custom_input)).to eq true
      end
    end
  end
end
