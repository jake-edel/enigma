class Enigma
  def self.encrypt(message, key, date)
    shift_array = Encryptor.find_shifts(key, date)
    encryption_hash
  end

  def self.decrypt(ciphertext, key, date)
    encryption_hash
  end
end
