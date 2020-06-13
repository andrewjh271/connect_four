require './lib/board.rb'
require './lib/color.rb'

describe Board do
  subject { Board.new }
  # before { allow($stdout).to receive(:write) }

  describe '#display' do
    it 'displays empty board at beginning of game' do
      expect { subject.display }.to output(
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
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      subject.move(player, 'd')
      expect { subject.display }.to output(
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
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      player2 = double(:player2)
      allow(player2).to receive(:first?).and_return(false)
      3.times { subject.move(player, 'd') }
      2.times { subject.move(player2, 'd') }
      2.times { subject.move(player2, 'g') }
      expect { subject.display }.to output(
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

  describe '#winning_direction' do
    

    it 'returns winning direction if line of four discs exists after last move' do
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      4.times { subject.move(player, 'd') }
      expect(subject.winning_direction).to eq [0, -1]
    end

    it 'returns nil if no winning line exists' do
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      3.times { subject.move(player, 'd') }
      expect(subject.winning_direction).to be nil
    end

    it 'returns winning direction for diagonal' do
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      subject.move(player, 'c')
      2.times { subject.move(player, 'd') }
      3.times { subject.move(player, 'e') }
      4.times { subject.move(player, 'f') }
      expect(subject.winning_direction).to eq [-1, -1]
    end

    it 'does not detect win from different colored discs' do
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      player2 = double(:player2)
      allow(player2).to receive(:first?).and_return(false)
      subject.move(player, 'c')
      2.times { subject.move(player, 'd') }
      3.times { subject.move(player2, 'e') }
      subject.move(player2, 'f')
      3.times { subject.move(player, 'f') }
      expect(subject.winning_direction).to be nil
    end

    it 'does not accept rows that go out of bounds' do
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      player2 = double(:player2)
      allow(player2).to receive(:first?).and_return(false)
      3.times { subject.move(player, 'a') }
      4.times { subject.move(player2, 'a') }
      expect(subject.winning_direction).to be nil
    end
  end

  describe '#display_win' do
    it 'displays winning row' do
      # allow(subject).to receive(:winning_direction).and_return([-1, 1])
      player = double(:player)
      allow(player).to receive(:first?).and_return(true)
      player2 = double(:player2)
      allow(player2).to receive(:first?).and_return(false)
      3.times { subject.move(player, 'e') }
      subject.move(player, 'd')
      subject.move(player, 'c')
      subject.move(player2, 'c')
      subject.move(player2, 'b')
      subject.move(player2, 'd')
      subject.move(player2, 'e')
      subject.display_win([-1, -1])

      expect { subject.display }.to output(
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
      @player = double(:player)
      allow(@player).to receive(:first?).and_return(true)
      @player2 = double(:player2)
      allow(@player2).to receive(:first?).and_return(false)
      ('a'..'f').each do |col|
        3.times do
          subject.move(@player, col)
          subject.move(@player2, col)
        end
      end
    end


    it 'returns false if board is not full' do
      expect(subject.stalemate?).to be false
    end

    it 'returns true if board is full' do
      3.times do
        subject.move(@player, 'g')
        subject.move(@player2, 'g')
      end
      expect(subject.stalemate?).to be true
    end
  end
end