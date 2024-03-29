require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    #
    # --- Day 5: Supply Stacks ---

    # The expedition can depart as soon as the final supplies have been unloaded from the ships. Supplies are stored in stacks of marked crates, but because the needed supplies are buried under many other crates, the crates need to be rearranged.

    # The ship has a giant cargo crane capable of moving crates between stacks. To ensure none of the crates get crushed or fall over, the crane operator will rearrange them in a series of carefully-planned steps. After the crates are rearranged, the desired crates will be at the top of each stack.

    # The Elves don't want to interrupt the crane operator during this delicate procedure, but they forgot to ask her which crate will end up where, and they want to be ready to unload them as soon as possible so they can embark.

    # They do, however, have a drawing of the starting stacks of crates and the rearrangement procedure (your puzzle input). For example:

    #     [D]
    # [N] [C]
    # [Z] [M] [P]
    #  1   2   3

    # move 1 from 2 to 1
    # move 3 from 1 to 3
    # move 2 from 2 to 1
    # move 1 from 1 to 2

    # In this example, there are three stacks of crates. Stack 1 contains two crates: crate Z is on the bottom, and crate N is on top. Stack 2 contains three crates; from bottom to top, they are crates M, C, and D. Finally, stack 3 contains a single crate, P.

    # Then, the rearrangement procedure is given. In each step of the procedure, a quantity of crates is moved from one stack to a different stack. In the first step of the above rearrangement procedure, one crate is moved from stack 2 to stack 1, resulting in this configuration:

    # [D]
    # [N] [C]
    # [Z] [M] [P]
    #  1   2   3

    # In the second step, three crates are moved from stack 1 to stack 3. Crates are moved one at a time, so the first crate to be moved (D) ends up below the second and third crates:

    #         [Z]
    #         [N]
    #     [C] [D]
    #     [M] [P]
    #  1   2   3

    # Then, both crates are moved from stack 2 to stack 1. Again, because crates are moved one at a time, crate C ends up below crate M:

    #         [Z]
    #         [N]
    # [M]     [D]
    # [C]     [P]
    #  1   2   3

    # Finally, one crate is moved from stack 1 to stack 2:

    #         [Z]
    #         [N]
    #         [D]
    # [C] [M] [P]
    #  1   2   3

    # The Elves just need to know which crate will end up on top of each stack; in this example, the top crates are C in stack 1, M in stack 2, and Z in stack 3, so you should combine these together and give the Elves the message CMZ.

    # After the rearrangement procedure completes, what crate ends up on top of each stack?

    it 'input gets separates into two parts' do
      expected_start_stack = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 "

      expected_moves =
        <<~MOVES
          move 1 from 2 to 1
          move 3 from 1 to 3
          move 2 from 2 to 1
          move 1 from 1 to 2
        MOVES
      expect(separate_inputs(example_input)).to eq(
        [
          expected_start_stack,
          expected_moves
        ]
      )
    end

    let(:starting_stack) do
      {
        1 => %w[Z N],
        2 => %w[M C D],
        3 => %w[P]
      }
    end

    it 'converts start stack input to a correct data structure' do
      stack = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 "
      expect(translate_crate_stack(stack)).to eq(starting_stack)
    end

    let(:translated_move_instructions) do
      [
        { start: 2, finish: 1, size: 1 },
        { start: 1, finish: 3, size: 3 },
        { start: 2, finish: 1, size: 2 },
        { start: 1, finish: 2, size: 1 }
      ]
    end

    it 'converts move instructions to a correct data set' do
      string_move_instructions =
        <<~MOVES
          move 1 from 2 to 1
          move 3 from 1 to 3
          move 2 from 2 to 1
          move 1 from 1 to 2
        MOVES

      expect(translate_moves(string_move_instructions)).to eq(translated_move_instructions)
    end

    it 'produces correct stack map after a one move' do
      instruction = translated_move_instructions.first
      expect(move_crates(starting_stack, instruction)).to eq(
        {
          1 => %w[Z N D],
          2 => %w[M C],
          3 => %w[P]
        }
      )
    end

    it 'produces correct stack map after a two moves' do
      instructions = translated_move_instructions.shift 2
      expect(execute_moves(starting_stack, instructions)).to eq(
        {
          1 => %w[],
          2 => %w[M C],
          3 => %w[P D N Z]
        }
      )
    end

    let(:final_stack_state) do
      {
        1 => %w[C],
        2 => %w[M],
        3 => %w[P D N Z]
      }
    end
    it 'produces correct stack map after a all moves' do
      expect(execute_moves(starting_stack, translated_move_instructions)).to eq(final_stack_state)
    end

    it 'finds top crates from each stack' do
      expect(find_top_crates(final_stack_state)).to eq 'CMZ'
    end

    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns correct result' do
          expect(solution_pt1(example_input)).to eq 'CMZ'
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          expect(solution_pt1(custom_input)).to eq 'RFFFWBPNS'
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # --- Part Two ---

    # As you watch the crane operator expertly rearrange the crates, you notice the process isn't following your prediction.

    # Some mud was covering the writing on the side of the crane, and you quickly wipe it away. The crane isn't a CrateMover 9000 - it's a CrateMover 9001.

    # The CrateMover 9001 is notable for many new and exciting features: air conditioning, leather seats, an extra cup holder, and the ability to pick up and move multiple crates at once.

    # Again considering the example above, the crates begin in the same configuration:

    #     [D]
    # [N] [C]
    # [Z] [M] [P]
    #  1   2   3

    # Moving a single crate from stack 2 to stack 1 behaves the same as before:

    # [D]
    # [N] [C]
    # [Z] [M] [P]
    #  1   2   3

    # However, the action of moving three crates from stack 1 to stack 3 means that those three moved crates stay in the same order, resulting in this new configuration:

    #         [D]
    #         [N]
    #     [C] [Z]
    #     [M] [P]
    #  1   2   3

    # Next, as both crates are moved from stack 2 to stack 1, they retain their order as well:

    #         [D]
    #         [N]
    # [C]     [Z]
    # [M]     [P]
    #  1   2   3

    # Finally, a single crate is still moved from stack 1 to stack 2, but now it's crate C that gets moved:

    #         [D]
    #         [N]
    #         [Z]
    # [M] [C] [P]
    #  1   2   3

    # In this example, the CrateMover 9001 has put the crates in a totally different order: MCD.

    # Before the rearrangement process finishes, update your simulation so that the Elves know where they should stand to be ready to unload the final supplies. After the rearrangement procedure completes, what crate ends up on top of each stack?

    context 'example input data' do
      it 'returns correct result' do
        expect(solution_pt2(example_input)).to eq 'MCD'
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        expect(solution_pt2(custom_input)).to eq 'CQQBBJFCS'
      end
    end
  end
end
