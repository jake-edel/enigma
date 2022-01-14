require './lib/character_shifter'

 RSpec.describe CharacterShifter do
  before(:each) do
    @message = 'Hello World'
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
    
  end

end
