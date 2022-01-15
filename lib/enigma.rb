require './lib/offset_finder'
require './lib/character_shifter'
require './lib/key_gen'


class Enigma
  include OffsetFinder
  include KeyGen

  def self.encrypt(message, key = generate_key, date = generate_date)
    shift_array = OffsetFinder.find_shifts(key, date)
    {
    encryption: CharacterShifter.new(message, shift_array).shift_message,
    key: key,
    date: date
    }
  end

  def self.decrypt(cipher_text, key, date = KeyGen.generate_date)
    shift_array = OffsetFinder.find_shifts(key, date)
    {
    decryption: CharacterShifter.new(cipher_text, shift_array).shift_message(true),
    key: key,
    date: date
    }
  end
end
