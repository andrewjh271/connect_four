require './lib/player.rb'

describe Player do
  describe '#name' do
    it 'returns name' do
      player1 = Player.new('Andrew', 1)
      expect(player1.name).to eq 'Andrew'
    end
  end

  describe '#first?' do
    player1 = Player.new('Andrew', 1)
    player2 = Player.new('Beth', 2)

    it { expect(player1).to be_first }
    it { expect(player2).not_to be_first }
  end
end