# frozen_string_literal: true

require File.join(__dir__, 'solution')

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'data/ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'data/input')) }

  describe 'Part 1' do
    describe 'final result for pt1' do
      context 'with example input data' do
        it 'returns correct result' do
          expect(Solution.new(example_input).solution_pt1).to eq 2
        end
      end

      context 'with custom input data' do
        it 'returns correct result' do
          expect(Solution.new(custom_input).solution_pt1).to eq 332
        end
      end
    end
  end

  describe 'Part 2' do
    context 'with example input data' do
      it 'returns correct result' do
        expect(Solution.new(example_input).solution_pt2).to eq 4
      end
    end

    context 'with custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(Solution.new(custom_input).solution_pt2).to eq true
      end
    end
  end
end
