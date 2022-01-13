class Encryptor

  def self.find_shifts(key, date)
    consec_keys = find_consecutive_values(key)

  end

  def self.find_consecutive_values(string)
    string.chars.each_cons(2).map { |cons| cons.join('').to_i }
  end
end
