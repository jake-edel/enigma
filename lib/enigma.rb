require './lib/offset_finder'
require './lib/character_shifter'


class Enigma
  def self.encrypt(message, key, date)
    shift_array = OffsetFinder.find_shifts(key, date)
    encrypted_message = CharacterShifter.new(message, shift_array).shift_message
    Hash.new
  end

  def self.decrypt(ciphertext, key, date)
    Hash.new
  end
end
