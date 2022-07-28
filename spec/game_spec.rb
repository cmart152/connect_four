require_relative '../lib/game.rb'
require_relative '../lib/user.rb'

describe Game do
  let(:user_1) {double(User.new('Fran', 'piece'))}
  let(:user_2) {double(User.new('Chet', 'piece'))}
  subject(:game) { described_class.new(user_1, user_2) }

  describe 'check_input' do
    before do
      allow(game).to receive(:gets).and_return('4')
      allow(game).to receive(:puts).with('Enter a number between 1-7 that corresponds to a column in the cage')
    end

    it 'User input is between 1-7' do
      expect(game.check_input(2)).to be(2)
    end

    it 'User input is invalid then a valid input is entered' do
      expect(game.check_input(10)).to be(4)
    end
  end

  describe 'check_play_again' do
    before do
      allow(game).to receive(:gets).and_return('t', 'y')
      allow(game).to receive(:puts)
    end

    it 'input is y and returns y' do
      expect(game.check_play_again('y')).to eq('y')
    end

    it 'input is invalid on first 2 attempts then correct input given' do
      expect(game).to receive(:puts).with("Enter 'y' to play again or 'n' to end game").twice
      game.check_play_again('v')
    end
  end

  
end