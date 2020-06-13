require './lib/board.rb'
require './lib/color.rb'

describe Board do

  attr_reader :player, :player2

  subject { Board.new }
  before do 
    # allow($stdout).to receive(:write)
    @player = double(:player)
    allow(@player).to receive(:first?).and_return(true)
    @player2 = double(:player2)
    allow(@player2).to receive(:first?).and_return(false)
  end

  describe '#display' do
    it 'displays empty board at beginning of game' do
      expect { subject.display }.to output(
        "\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "  a   b   c   d   e   f   g\n"
      ).to_stdout
    end

    it 'displays board reflecting new move' do
      subject.move(player, 'd')
      expect { subject.display }.to output(
        "\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.yellow} ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "  a   b   c   d   e   f   g\n"
      ).to_stdout
    end

    it 'displays board reflecting multiple moves' do
      3.times { subject.move(player, 'd') }
      2.times { subject.move(player2, 'd') }
      2.times { subject.move(player2, 'g') }
      expect { subject.display }.to output(
        "\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.red} ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.red} ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.yellow} ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.yellow} ┆   ┆   ┆ #{'◉'.red} ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'◉'.yellow} ┆   ┆   ┆ #{'◉'.red} ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "  a   b   c   d   e   f   g\n"
      ).to_stdout
    end
  end

  describe '#check_for_win' do
    # before { win_start = double(:@win_start) }
    
    it 'returns true if row of 4 is on board' do
      4.times { subject.move(player, 'd') }
      expect(subject.check_for_win).to be true
    end

    it 'returns false if no winning line exists' do
      3.times { subject.move(player, 'd') }
      expect(subject.check_for_win).to be false
    end

    it 'returns true for diagonal row' do
      3.times { subject.move(player, 'e') }
      subject.move(player, 'd')
      subject.move(player, 'c')
      subject.move(player2, 'b')
      subject.move(player2, 'c')
      2.times { subject.move(player2, 'd') }
      subject.move(player2, 'e')
      expect(subject.check_for_win).to be true
    end

    it 'does not detect win from different colored discs' do
      subject.move(player, 'c')
      2.times { subject.move(player, 'd') }
      3.times { subject.move(player2, 'e') }
      subject.move(player2, 'f')
      3.times { subject.move(player, 'f') }
      expect(subject.check_for_win).to be false
    end

    it 'does not accept rows that go out of bounds' do
      3.times { subject.move(player, 'a') }
      4.times { subject.move(player2, 'a') }
      expect(subject.check_for_win).to be false
    end
  end

  describe '#set_win' do
    it 'sets winning row' do
      3.times { subject.move(player, 'e') }
      subject.move(player, 'd')
      subject.move(player, 'c')
      subject.move(player2, 'b')
      subject.move(player2, 'c')
      2.times { subject.move(player2, 'd') }
      subject.move(player2, 'e')
      subject.set_win if subject.check_for_win

      expect { subject.display }.to output(
        "\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆   ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆   ┆ #{'★'.red} ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆   ┆ #{'★'.red} ┆ #{'◉'.yellow} ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆   ┆ #{'★'.red} ┆ #{'◉'.red} ┆ #{'◉'.yellow} ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "┆   ┆ #{'★'.red} ┆ #{'◉'.yellow} ┆ #{'◉'.yellow} ┆ #{'◉'.yellow} ┆   ┆   ┆\n" \
        "┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈\n" \
        "  a   b   c   d   e   f   g\n"
      ).to_stdout
    end
  end

  describe '#stalemate?' do
    before do
      ('a'..'f').each do |col|
        3.times do
          subject.move(player, col)
          subject.move(player2, col)
        end
      end
    end

    it 'returns false if board is not full' do
      expect(subject.stalemate?).to be false
    end

    it 'returns true if board is full' do
      3.times do
        subject.move(player, 'g')
        subject.move(player2, 'g')
      end
      expect(subject.stalemate?).to be true
    end
  end
end