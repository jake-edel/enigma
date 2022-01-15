require './lib/character_shifter'

 RSpec.describe CharacterShifter do
  before(:each) do
    @message = 'Hello, World'
    @shifts = [3, 27, 73, 20]
    @character_shifter = CharacterShifter.new(@message, @shifts)
  end

  it 'is initialized with a message to be encoded, and an array of 4 offset keys' do
    expect(@message).to be_a String
    expect(@shifts).to be_an Array
    @shifts.each do |shift|
      expect(shift).to be_an Integer
    end
    expect(@character_shifter).to be_a CharacterShifter
  end

  describe '#shift_message' do
    it 'returns an the message encrypted according to the given shifts' do
      encrypted = @character_shifter.shift_message
      expect(encrypted).to be_a String
      expect(encrypted).to eq 'keder, ohulw'
    end
  end

  describe '#shift_char' do
    it 'takes a character and a shift value and returns a shifted value from the char set' do
      expect(@character_shifter.shift_char('a', 1)).to eq 'b'
      expect(@character_shifter.shift_char('y', 2)).to eq ' '
      expect(@character_shifter.shift_char('y', 3)).to eq 'a'
      expect(@character_shifter.shift_char('z', 4)).to eq 'c'
      expect(@character_shifter.shift_char('z', 27)).to eq 'z'
      expect(@character_shifter.shift_char('a', 28)).to eq 'b'
      expect(@character_shifter.shift_char('a', 29)).to eq 'c'
      expect(@character_shifter.shift_char('a', 30)).to eq 'd'
    end
  end
end
