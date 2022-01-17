require './lib/crack'

RSpec.describe CodeCracker do
  before :each do
    @hash = {
      encryption: 'vjqtbeaweqihssi',
      key: '08304',
      date: '291018'
    }
  end

  it 'takes an encrypted message, and optional date, and returns the unencrypted message, and encryption key' do
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }
    CodeCracker.crack(@hash[:encryption], @hash[:date])
  end

  describe '#locate_shifts' do
    it 'finds the pattern of shifts mapped to the last four characters of the string' do
      expect(CodeCracker.locate_shifts(' end')).to eq [0, 1, 2, 3]
      expect(CodeCracker.locate_shifts('x end')).to eq [1, 2, 3, 0]
      expect(CodeCracker.locate_shifts('xx end')).to eq [2, 3, 0, 1]
      expect(CodeCracker.locate_shifts('xxx end')).to eq [3, 0, 1, 2]
    end
  end

  describe 'pattern_map' do
    it 'maps the signature " end" to the last four characters of the encrypted message, ordered by shift poision' do
      expected = [["d", "i"], [" ", "h"], ["e", "s"], ["n", "s"]]
      expect(CodeCracker.pattern_map(' end', 'hssi', [3, 0, 1, 2])).to eq expected

      expected = [[" ", "h"], ["e", "s"], ["n", "s"], ["d", "i"]]
      expect(CodeCracker.pattern_map(' end', 'hssi', [0, 1, 2, 3])).to eq expected

      expected = [["n", "s"], ["d", "i"], [" ", "h"], ["e", "s"]]
      expect(CodeCracker.pattern_map(' end', 'hssi', [2, 3, 0, 1])).to eq expected
    end
  end

  describe 'calculate_shifts' do
    it 'takes the previous character hash, and calulates the shifts required for the key character to shift to the value character' do

      char_array = [["d", "i"], [" ", "h"], ["e", "s"], ["n", "s"]]
      expect(CodeCracker.calculate_shifts(char_array)).to eq [5, 8, 14, 5]

    end

    it 'return value will correctly shift the encrypted signature to the unencrypted signature' do
      char_array = [["d", "i"], [" ", "h"], ["e", "s"], ["n", "s"]]
      expect(CharacterShifter.new('vjqtbeaweqihssi', [14, 5, 5, 8]).shift_message(true)[-4..-1]).to eq ' end'
    end
  end

  describe '#rotate_shifts' do
    it 'rotates the shifts array to match indecies with shift positions' do
      expect(CodeCracker.rotate_shifts([5, 8, 14, 5], [3, 0, 1, 2])).to eq [8, 14, 5, 5]
    end
  end
end
