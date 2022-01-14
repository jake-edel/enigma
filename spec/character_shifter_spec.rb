require './lib/character_shifter'

 RSpec.describe CharacterShifter do
  before(:each) do
    message = 'Hello World'
    offsets = []
    @character_shifter = CharacterShifter.new(message, offsets)
  end

  it 'is initialized with a message to be encoded, and an array of 4 offset keys' do
    expect(@character_shifter).to be_instance_of CharacterShifter
    expect(@character_shifter).to be_instance_of CharacterShifter
    expect(@character_shifter).to be_instance_of CharacterShifter
  end
end
