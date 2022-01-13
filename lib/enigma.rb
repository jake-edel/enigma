require './lib/encryptor'

class Enigma
  def self.encrypt(message, key, date)
    shift_array = Encryptor.find_shifts(key, date)
    Hash.new
  end

  def self.decrypt(ciphertext, key, date)
    Hash.new
  end
end
