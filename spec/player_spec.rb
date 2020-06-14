# frozen_string_literal: true

require './lib/player.rb'

describe Player do
  describe '#name' do
    it 'returns name' do
      player1 = Player.new('Andrew', 1)
      expect(player1.name).to eq "\e[33mAndrew\e[0m"
    end

    it 'returns name for 2nd player' do
      player2 = Player.new('Andrew', 2)
      expect(player2.name).to eq "\e[31mAndrew\e[0m"
    end
  end

  describe '#first?' do
    player1 = Player.new('Andrew', 1)
    player2 = Player.new('Beth', 2)

    it { expect(player1).to be_first }
    it { expect(player2).not_to be_first }
  end
end
