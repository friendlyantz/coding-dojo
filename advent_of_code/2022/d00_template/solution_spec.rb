require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    describe 'final result for pt1' do
      context 'example input data' do
        it 'return correct result' do
          expect(solution_pt2(example_input)).to eq 24_000
        end
      end

      context 'custom input data' do
        it 'return correct result' do
          pending 'pt1 implementation'
          expect(solution_pt2(custom_input)).to eq 'test input'
        end
      end
    end
  end

  describe 'final result for pt2' do
    context 'example input data' do
      it 'return correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(example_input)).to eq 'solution for part 2'
      end
    end

    context 'custom input data' do
      it 'return correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(custom_input)).to eq 'solution for part 2'
      end
    end
  end
end