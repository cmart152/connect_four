require_relative '../lib/game.rb'

describe Board do
  subject(:game) { described_class.new }

  describe 'create_empty_cage' do
    it 'creates an array' do
      expect(game.create_empty_cage).to be_an_instance_of(Array)
    end

    it 'creates nested arrays' do
      arr = game.create_empty_cage
      expect(arr[2]).to be_an_instance_of(Array)
    end

    it 'creates empty circles in sub arrays' do
      arr = game.create_empty_cage
      expect(arr[2][2]).to be_an_instance_of(String)
    end
  end

  describe 'check_for_space' do
    it 'returns true if space is empty' do
      expect(game.check_for_space(2)).to be(true)
    end

    it 'returns false if column is not empty' do
      game.cage[0][1] = 'not empty'
      game.cage[1][1] = 'not empty'
      game.cage[2][1] = 'not empty'
      game.cage[3][1] = 'not empty'
      game.cage[4][1] = 'not empty'
      game.cage[5][1] = 'not empty'
      expect(game.check_for_space(2)).to be(false)
    end
  end

  describe 'check_for_win' do
    it 'no win returns false' do
      expect(game.check_for_win('not empty')).to be(false)
    end

    it '4 in a row vertical returns true' do
      game.cage[2][0] = 'not empty'
      game.cage[3][0] = 'not empty'
      game.cage[4][0] = 'not empty'
      game.cage[5][0] = 'not empty'
      expect(game.check_for_win('not empty')).to be(true)
    end

    it '4 in a row horizontal returns true' do
      game.cage[1][2] = 'not empty'
      game.cage[1][3] = 'not empty'
      game.cage[1][4] = 'not empty'
      game.cage[1][5] = 'not empty'
      expect(game.check_for_win('not empty')).to be(true)
    end

    it '4 in a row diagonal left returns true' do
      game.cage[5][0] = 'not empty'
      game.cage[4][1] = 'not empty'
      game.cage[3][2] = 'not empty'
      game.cage[2][3] = 'not empty'
      expect(game.check_for_win('not empty')).to be(true)
    end

    it '4 in a row diagonal right returns true' do
      game.cage[0][0] = 'not empty'
      game.cage[1][1] = 'not empty'
      game.cage[2][2] = 'not empty'
      game.cage[3][3] = 'not empty'
      expect(game.check_for_win('not empty')).to be(true)
    end

    it 'check for win diagonal right bottom left' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      ['x', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', 'x', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', 'x', 'x', ' ', ' ', ' '],
      [' ', ' ', ' ', 'x', 'x', 'x', 'x']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'check for win diagonal right bottom right' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', 'x', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', 'x', ' ', ' '],
      [' ', ' ', 'x', 'x', ' ', 'x', ' '],
      [' ', ' ', ' ', ' ', 'x', 'x', 'x']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'check for win diagonal left bottom left' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', 'x', ' ', ' ', ' '],
      [' ', ' ', 'x', ' ', ' ', ' ', ' '],
      [' ', 'x', 'x', 'x', ' ', ' ', ' '],
      ['x', ' ', ' ', 'x', ' ', 'x', 'x']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'check for win on bottom row' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', 'x', 'x', ' ', ' ', ' '],
      [' ', ' ', ' ', 'x', 'x', 'x', 'x']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'check for win on right column' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', 'x'],
      [' ', ' ', ' ', ' ', ' ', ' ', 'x'],
      [' ', ' ', 'x', 'x', ' ', ' ', 'x'],
      [' ', ' ', 'x', 'x', ' ', 'x', 'x']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'extra patterns thrown in while checking for win, expect false' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', 'o', ' ', ' ', ' ', ' '],
      [' ', ' ', 'x', ' ', 'x', ' ', ' '],
      [' ', 'o', 'x', 'x', 'o', 'o', 'x'],
      ['o', 'x', 'x', 'x', 'o', 'x', 'o']
      ]
      expect(game.check_for_win('x')).to be(false)
    end

    it 'extra patterns thrown in while checking for win, expect true' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', 'x', 'x'],
      [' ', ' ', 'o', ' ', 'o', 'x', 'o'],
      [' ', ' ', 'x', 'x', 'x', 'o', ' '],
      [' ', 'o', 'x', 'x', 'o', 'o', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o']
      ]
      expect(game.check_for_win('x')).to be(true)
    end

    it 'extra patterns thrown in while checking for win, expect true' do
      game.cage = [
      [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      ['x', ' ', ' ', 'x', ' ', 'x', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o'],
      ['x', ' ', 'x', 'x', 'o', 'o', ' '],
      ['x', 'o', 'x', 'x', 'o', 'o', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o']
      ]
      expect(game.check_for_win('x')).to be(true)
    end
  end

  describe 'check_for_full' do
    it 'cage is full, returns true' do
      game.cage = [
      ['x', 'x', 'x', 'x', 'x', 'x', 'x'],
      ['x', 'x', 'x', 'x', ' ', 'x', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o'],
      ['x', 'x', 'x', 'x', 'o', 'o', 'x'],
      ['x', 'o', 'x', 'x', 'o', 'o', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o']
      ]
      expect(game.check_for_full).to be(true)
    end

    it 'cage has 1 space' do
      game.cage = [
      ['\u25ef ', 'x', 'x', 'x', 'x', 'x', 'x'],
      ['x', 'x', 'x', 'x', 'x', 'x', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o'],
      ['x', 'x', 'x', 'x', 'o', 'o', ' '],
      ['x', 'o', 'x', 'x', 'o', 'o', 'x'],
      ['o', 'x', 'o', 'o', 'o', 'x', 'o']
      ]
    end
  end


end