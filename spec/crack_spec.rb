require './lib/crack'

RSpec.describe CodeCracker do
  before :each do
    @hash = {
      # encryption: 'vjqtbeaweqihssi',
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
    # expect(CodeCracker.crack(@hash[:encryption], @hash[:date])).to eq(expected)
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
      expected = {
        'd' => 'i',
        ' ' => 'h',
        'e' => 's',
        'n' => 's'
      }
      expect(CodeCracker.pattern_map(' end', 'hssi', [3, 0, 1, 2])).to eq expected

      expected = {
        ' ' => 'a',
        'e' => 'b',
        'n' => 'c',
        'd' => 'd'
      }
      expect(CodeCracker.pattern_map(' end', 'abcd', [0, 1, 2, 3])).to eq expected

      expected = {
        'n' => 'c',
        'd' => 'd',
        ' ' => 'a',
        'e' => 'b'
      }
      expect(CodeCracker.pattern_map(' end', 'abcd', [2, 3, 0, 1])).to eq expected
    end
  end

  describe 'calculate_shifts' do
    it 'takes the previous character hash, and calulates the shifts required for the key character to shift to the value character' do
      hash_map = { 'd' => 'i', ' ' => 'h', 'e' => 's', 'n' => 's' }
      expect(CodeCracker.calculate_shifts(hash_map)).to eq [5, 8, 14, 5]

      hash_map = { ' ' => 'a', 'e' => 'b', 'n' => 'c', 'd' => 'd' }
      expect(CodeCracker.calculate_shifts(hash_map)).to eq [1, 24, 16, 0]
    end

    it 'return value will correctly shift the encrypted signature to the unencrypted signature' do
      hash_map = { 'd' => 'i', ' ' => 'h', 'e' => 's', 'n' => 's' }
      h = CodeCracker.calculate_shifts(hash_map.invert)
      require 'pry-byebug'; binding.pry
      expect(CharacterShifter.new('hssi', [5, 8, 14 , 5]).shift_message).to eq ' end'
    end
  end

  describe 'rotate_shifts' do
    it 'rotates the shifts array to match indecies with shift positions' do
      expect(CodeCracker.rotate_shifts([5, 8, 14, 5], [3, 0, 1, 2])).to eq [8, 14, 5, 5]
    end

    it 'return value is array of shifts which will '
  end
end
