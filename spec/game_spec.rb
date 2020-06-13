require './lib/game.rb'
require './lib/player.rb'

describe Game do

  attr_reader :board, :player

  subject { Game.new }
  before { @player = double(:player, name: 'Andrew', first?: true) }

  describe '#query_move' do
    it "calls Board#move(player, 'c') for user input 'c'" do
      allow(subject).to receive(:gets).and_return('c')
      expect { subject.query_move(player) }.to output(
        "Select column for Andrew's move: "
      ).to_stdout
      expect(subject.query_move(player)).to eq 'c'
    end

    it 'does not accept invalid columns' do
      allow(subject).to receive(:gets).and_return('h', 'g')
      expect { subject.query_move(player) }.to output(
        "Select column for Andrew's move: " \
        "Select column for Andrew's move (e.g., b): "
      ).to_stdout
      expect(subject.query_move(player)).to eq 'g'
    end
  end

  describe '#query_name' do
    it 'asks for name and returns response' do
      allow(subject).to receive(:gets).and_return('Andrew')
      expect(subject.query_name(1)).to eq('Andrew')
    end
  end
end
