# frozen_string_literal: true

require './lib/game.rb'
require './lib/player.rb'

describe Game do
  attr_reader :board, :player

  before do
    allow($stdout).to receive(:write)
    @player = double(:player, name: 'Andrew', first?: true)
  end

  describe '#query_move' do
    it 'prompts for user input and returns it' do
      # This line works if I call rspec on this specific file, but not if I call rspec files
      # as a group. (Having to do with Kernel reading from where file was called).
      # allow(subject).to receive(:gets).and_return('c')
      allow_any_instance_of(Kernel).to receive(:gets).and_return('c')
      # Using subject with the above Kernel mock causes expectation to read output on instantiation.
      game = Game.new
      expect { game.query_move(player) }.to output(
        "Select column for Andrew's move: "
      ).to_stdout
      expect(subject.query_move(player)).to eq 'c'
    end

    it 'does not accept invalid columns' do
      # allow_any_instance_of does not support multiple returns, but adding it allows me to run
      # rspec files as a group (whether I use Object or Kernel doesn't seem to matter here)
      allow_any_instance_of(Object).to receive(:gets).and_return('*not_read*')
      game = Game.new
      allow(game).to receive(:gets).and_return('h', 'g')
      expect { game.query_move(player) }.to output(
        "Select column for Andrew's move: " \
        "\e[1A" \
        "\e[2K" \
        "\e[31mSelect column for Andrew's move (e.g., b): \e[0m"
      ).to_stdout
      expect(game.query_move(player)).to eq 'g'
    end
  end

  describe '#query_name' do
    it 'asks for name and returns response' do
      # allow(subject).to receive(:gets).and_return('Andrew')
      allow_any_instance_of(Object).to receive(:gets).and_return('Andrew')
      game = Game.new
      expect(game.query_name(1)).to eq('Andrew')
    end
  end
end
