# frozen_string_literal: true

require_relative 'polymerization'
require 'pry'
require 'super_diff/rspec'

RSpec.describe Polymerization do
  let(:input) do
    <<~HEREDOC
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    HEREDOC
  end

  let(:poly) { described_class.new(input) }

  describe 'initialization' do
    let(:expected_rules) do
      [%w[CH B],
       %w[HH N],
       %w[CB H],
       %w[NH C],
       %w[HB C],
       %w[HC B],
       %w[HN C],
       %w[NN C],
       %w[BH H],
       %w[NC B],
       %w[NB B],
       %w[BN B],
       %w[BB N],
       %w[BC B],
       %w[CC N],
       %w[CN C]]
    end

    it 'initializes the object with correct variables' do
      expect(poly).to be_an_instance_of(described_class)
      expect(poly.template).to eq 'NNCB'
      expect(poly.rules).to eq(expected_rules)
    end
  end

  describe 'polymerization' do
    it 'find_matching_rules' do
      expect(poly.find_matching_rules).to eq(
        [%w[CB H], %w[NN C], %w[NC B]]
      )
    end

    context 'with only one step specified' do
      before { poly.step }

      it 'returns NCNBCHB after 1st step' do
        expect(poly.template).to eq 'NCNBCHB'
      end
    end

    context 'with two steps specified' do
      before { poly.steps(2) }

      it 'returns NBCCNBBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBCCNBBBCBHCB'
      end
    end

    context 'with three steps specified' do
      before { poly.steps(3) }

      it 'returns NBBBCNCCNBBNBNBBCHBHHBCHB after 1st step' do
        expect(poly.template).to eq 'NBBBCNCCNBBNBNBBCHBHHBCHB'
      end
    end

    context 'with four steps specified' do
      before { poly.steps(4) }

      it 'returns NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB'
      end
    end
  end

  describe 'puzzle one solution' do
    it 'after 10 steps quantity of the most common element(1749) and subtract the quantity of the least common element(161) returns 1588' do
      expect(poly.solve_part_one).to eq 1588
    end
  end
end

RSpec.describe FastPolymerization do
  let(:input) do
    <<~HEREDOC
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    HEREDOC
  end

  let(:poly) { described_class.new(input) }

  describe 'initialization' do
    let(:expected_rules) do
      [%w[CH B],
       %w[HH N],
       %w[CB H],
       %w[NH C],
       %w[HB C],
       %w[HC B],
       %w[HN C],
       %w[NN C],
       %w[BH H],
       %w[NC B],
       %w[NB B],
       %w[BN B],
       %w[BB N],
       %w[BC B],
       %w[CC N],
       %w[CN C]]
    end

    it 'initializes the object with correct variables' do
      expect(poly).to be_an_instance_of(described_class)
      expect(poly.template).to eq({ %w[N N] => 1, %w[N C] => 1, %w[C B] => 1 })
      expect(poly.rules).to eq(expected_rules)
    end
  end

  describe 'polymerization' do
    it 'find_matching_rules' do
      expect(poly.count_matching_rules).to eq(
        [['CB', 'H', 1], ['NN', 'C', 1], ['NC', 'B', 1]]
      )
    end

    context 'with only one step specified' do
      before { poly.step }

      it 'returns NCNBCHB after 1st step' do
        expect(poly.template).to eq 'NCNBCHB'.chars.each_cons(2).tally
      end
    end

    context 'with two steps specified' do
      before { poly.steps(2) }

      it 'returns NBCCNBBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBCCNBBBCBHCB'.chars.each_cons(2).tally
      end
    end

    context 'with three steps specified' do
      before { poly.steps(3) }

      it 'returns NBBBCNCCNBBNBNBBCHBHHBCHB after 1st step' do
        expect(poly.template).to eq 'NBBBCNCCNBBNBNBBCHBHHBCHB'.chars.each_cons(2).tally
      end
    end

    context 'with four steps specified' do
      before { poly.steps(4) }

      it 'returns NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB'.chars.each_cons(2).tally
      end
    end
  end

  describe 'puzzle one solution' do
    it 'after 10 steps quantity of the most common element(1749) and subtract the quantity of the least common element(161) returns 1588' do
      expect(poly.solve_part_one).to eq 1588
    end
  end

  describe 'puzzle two solution' do
    it 'after 40 steps quantity of the most common element(1749) and subtract the quantity of the least common element(161) returns 2188189693529' do
      expect(poly.solve_part_two).to eq 2_188_189_693_529
    end
  end
end
