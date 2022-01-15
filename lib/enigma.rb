require './lib/offset_finder'
require './lib/character_shifter'


class Enigma
  def self.encrypt(message, key = KeyGen.generate_key, date = KeyGen.generate_date)
    shift_array = OffsetFinder.find_shifts(key, date)
      hash = {
      encryption: CharacterShifter.new(message, shift_array).shift_message,
      key: key,
      date: date
    }
  end

  def self.decrypt(ciphertext, key, date)
    Hash.new
  end
end
